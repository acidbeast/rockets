//
//  RocketNetworkService.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/12/23.
//

import Foundation
import NetworkDispatcher

protocol RocketNetworkServiceProtocol {
    func getRockets(
        onSuccess: @escaping ([Rocket]) -> Void,
        onError: @escaping (Error) -> Void
    )
}

final class RocketNetworkService: RocketNetworkServiceProtocol {
    
    private let service: NetworkDispatcher<SpaceXAPI>
    
    init(service: NetworkDispatcher<SpaceXAPI>) {
        self.service = service
    }
    
    func getRockets(
        onSuccess: @escaping ([Rocket]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        service.request(.rockets) { result in
            self.service.handle(
                result: result,
                onSuccess: onSuccess,
                onError: onError
            )
        }
    }
}
