//
//  TCPError.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import Foundation
import SwiftSocket

enum TCPError: Error{
    case connectionError(Error?)
    case sendRequestError(Error?)
    case readResponseError
    case creationError
    
    var localizedDescription: String {
        switch self {
        case .connectionError(let error):
            return "connectionError: \(String(describing: error))"
        case .sendRequestError(let error):
            return "sendRequestError: \(String(describing: error))"
        case .readResponseError:
            return "readResponseError"
        case .creationError:
            return "creationError"
        }
    }
}
