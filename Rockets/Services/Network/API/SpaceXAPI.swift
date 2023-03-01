//
//  SpaceXAPI.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/1/23.
//

import Foundation
import NetworkDispatcher

enum SpaceXAPI {
    case rockets
    case launches
}

extension SpaceXAPI: APIClient {
    var baseURL: URL {
        guard let url = URL(string: "https://api.spacexdata.com/v4/") else {
            fatalError("URL is not provided")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .rockets:
            return "rockets"
        case .launches:
            return "launches"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .rockets:
            return .get
        case .launches:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .rockets:
            return .request
        case .launches:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
    
    var decoder: JSONDecoder {
        NetworkService.decoder
    }
}
