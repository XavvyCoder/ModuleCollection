//
//  SampleService.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/27.
//

import Foundation
import Combine

enum SampleAPI {
    case fetchByName
    
    var url: URL {
        switch self {
        case .fetchByName: return URL(string: API_RESTCOUNTRIES_NAME + "japan")!
        }
    }
}

enum SampleAPIService {
    static func fetchByName() -> AnyPublisher<[CountryInfo], Error> {
        return URLSession.shared.dataTaskPublisher(for: SampleAPI.fetchByName.url)
            .map{ $0.data }
            .decode(type: [CountryInfo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
