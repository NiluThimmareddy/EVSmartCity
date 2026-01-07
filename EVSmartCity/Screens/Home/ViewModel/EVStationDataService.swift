//
//  EVStationDataService.swift
//  EVSmartCity
//
//  Created by Toqsoft on 07/01/26.
//

import Foundation
import Combine

protocol EVStationDataServiceProtocol {
    func fetchStations() -> AnyPublisher<[EVStation], Error>
}

class EVStationDataService: EVStationDataServiceProtocol {
    func fetchStations() -> AnyPublisher<[EVStation], Error> {
        return Future<[EVStation], Error> { promise in
            DispatchQueue.global(qos: .background).async {
                if let path = Bundle.main.path(forResource: "StationList", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path))
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(EVStationResponse.self, from: data)
                        promise(.success(response.evStations))
                    } catch {
                        promise(.failure(error))
                    }
                } else {
                    promise(.failure(NSError(domain: "FileNotFound", code: 404)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
