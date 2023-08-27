//
//  SampleViewModel.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/27.
//

import Foundation
import Combine

class SampleViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    func fetchByName() {
        SampleAPIService.fetchByName()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error: \(error)")
                }
            }, receiveValue: { (countryInfos: [CountryInfo]) in
                print("wow here it comes ->\n\(countryInfos)")
            }).store(in: &subscriptions)
    }
}
