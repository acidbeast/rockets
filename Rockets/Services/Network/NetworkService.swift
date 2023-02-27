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
}
