//
//  LaunchNetworkService.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/1/23.
//

import Foundation
import NetworkDispatcher

protocol LaunchNetworkServiceProtocol {
    func getLaunches(
        onSuccess: @escaping ([Launch]) -> Void,
        onError: @escaping (NetworkError) -> Void
    )
}

final class LaunchNetworkService: LaunchNetworkServiceProtocol {
    
    private let service: NetworkDispatcher<SpaceXAPI>
    
    init(service: NetworkDispatcher<SpaceXAPI>) {
        self.service = service
    }
        
    func getLaunches(
        onSuccess: @escaping ([Launch]) -> Void,
        onError: @escaping (NetworkError) -> Void
    ) {
        service.request(.launches) { result in
            self.service.handle(
                result: result,
                onSuccess: onSuccess,
                onError: onError
            )
        }
    }
}

