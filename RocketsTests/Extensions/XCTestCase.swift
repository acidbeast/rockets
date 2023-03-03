//
//  XCTestCase.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/3/23.
//

import XCTest
@testable import Rockets

extension XCTestCase {

    func getRocketMock() throws -> Rocket? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "RocketMock", withExtension: "json") else {
                XCTFail("Missing file: RocketMock.json")
                return nil
            }
        let json = try Data(contentsOf: url)
        let rocket = try NetworkService.decoder.decode(Rocket.self, from: json)
        return rocket
    }
    
    func getLaunchMock() throws -> Launch? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "LaunchMock", withExtension: "json") else {
                XCTFail("Missing file: LaunchMock.json")
                return nil
            }
        let json = try Data(contentsOf: url)
        let launch = try NetworkService.decoder.decode(Launch.self, from: json)
        return launch
    }
    
}
