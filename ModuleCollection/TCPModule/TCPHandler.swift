//
//  TCPHandler.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import UIKit
import SwiftSocket

class TCPHandler: NSObject {
    
    static let shared = TCPHandler()
    private override init() {}
    
    private var client: TCPClient?
    private var host = ""
    private var port: Int32 = -1
    private var request = ""
    
    func configureHostAndPort(host: String, port: Int32) {
        self.host = host
        self.port = port
    }
    
    func configureRequest(request: String) {
        self.request = request
    }
    
    func connectToServer() throws -> String {
        client = TCPClient(address: host, port: port)
        guard let client = client
        else {
            request = ""
            throw TCPError.creationError
        }
        
        let connectionResult = client.connect(timeout: 3)
        guard connectionResult == Result.success
        else {
            request = ""
            throw TCPError.connectionError(connectionResult.error)
        }
        
        let sendResult = client.send(string:request)
        guard sendResult == Result.success
        else {
            request = ""
            throw TCPError.sendRequestError(sendResult.error)
        }
        
        guard let unEncodedResponse = client.read(1024*10, timeout: 60*60), let encodedResponse = String(bytes: unEncodedResponse, encoding: .utf8)
        else {
            request = ""
            throw TCPError.readResponseError
        }
        
        request = ""
        return encodedResponse
    }
}

extension Result: Equatable {
    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success), (.failure(_:), .failure(_:)):
            return true
        default:
            return false
        }
    }
}
