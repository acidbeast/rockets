//
//  NetworkService.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/3/23.
//

import Foundation
import NetworkDispatcher

class NetworkService {
    static let spaceXAPI = NetworkDispatcher<SpaceXAPI>()
    static let rocketService = RocketNetworkService(service: spaceXAPI)
    static let launchService = LaunchNetworkService(service: spaceXAPI)
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
