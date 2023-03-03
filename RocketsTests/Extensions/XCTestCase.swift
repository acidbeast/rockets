//
//  XCTestCase.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/3/23.
//

import XCTest
@testable import Rockets


final class Mock<T:Decodable> {
    
    let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func getMock(fromFile: String) throws -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fromFile, withExtension: "json") else {
            XCTFail("Missing file: \(fromFile).json")
            return nil
        }
        let json = try Data(contentsOf: url)
        let mock = try jsonDecoder.decode(T.self, from: json)
        return mock
    }
}


extension XCTestCase {

    func getRocketMock() throws -> Rocket? {
        let mock = Mock<Rocket>(jsonDecoder: NetworkService.decoder)
        return try mock.getMock(fromFile: "RocketMock")
    }
    
    func getLaunchMock() throws -> Launch? {
        let mock = Mock<Launch>(jsonDecoder: NetworkService.decoder)
        return try mock.getMock(fromFile: "LaunchMock")
    }
        
}
