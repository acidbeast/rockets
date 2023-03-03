//
//  ModuleBuilderTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/1/23.
//

import XCTest
@testable import Rockets


final class ModuleBuilderTest: XCTestCase {

    let moduleBuilder = ModuleBuilder()
    let navigationController = UINavigationController()
    var router: MainRouterProtocol!
    
    override func setUp() {
        router = MainRouter(
            navigationController: navigationController,
            moduleBuilder: moduleBuilder
        )
    }

    override func tearDown() {
        router = nil
    }

    func testCreateMainModule() throws {
        let vc = moduleBuilder.createMainModule(router: router)
        XCTAssertTrue(vc is MainVC)
        XCTAssertTrue((vc as? MainVC)?.presenter is MainPresenter)
    }
    
    func testCreateErrorModule() throws {
        let vc = moduleBuilder.createErrorModule(router: router)
        XCTAssertTrue(vc is ErrorVC)
        XCTAssertTrue((vc as? ErrorVC)?.presenter is ErrorPresenter)
    }
    
    func testCreateRocketModule() throws {
        guard let rocket = try getRocketMock() else {
            XCTFail("Get Rocket instance failed.")
            return
        }
        let vc = moduleBuilder.createRocketsModule(rockets: [rocket], router: router)
        XCTAssertTrue(vc is RocketsVC)
        XCTAssertTrue((vc as? RocketsVC)?.presenter is RocketsPresenter)
        XCTAssertEqual((vc as? RocketsVC)?.presenter.rockets.count, 1)
    }
    
    func testCreateRocketPageModule() throws {
        guard let rocket = try getRocketMock() else {
            XCTFail("Get Rocket instance failed.")
            return
        }
        let vc = moduleBuilder.createRocketPageModule(rocket: rocket, router: router)
        XCTAssertTrue(vc is RocketPageVC)
        XCTAssertTrue((vc as? RocketPageVC)?.presenter is RocketsPagePresenter)
    }
    
    func testCreateSettingsModule() {
        let vc = moduleBuilder.createSettingModule(rocketId: "", router: router, onClose: nil)
        XCTAssertTrue(vc is SettingsVC)
        XCTAssertTrue((vc as? SettingsVC)?.presenter is SettingsPresenter)
    }

    func testCreateLaunchesModule() {
        let vc = moduleBuilder.createLaunchesModule(rocketId: "", rocketName: "", router: router)
        XCTAssertTrue(vc is LaunchesVC)
        XCTAssertTrue((vc as? LaunchesVC)?.presenter is LaunchesPresenter)
    }
    
}
