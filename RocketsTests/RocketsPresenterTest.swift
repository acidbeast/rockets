//
//  RocketsPresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/3/23.
//

import XCTest
@testable import Rockets


class RocketsMockView: RocketsViewProtocol {
    
    var showRocketsCallCounter = 0
    
    var presenter: RocketsPresenterProtocol!
    
    func showRockets() {
        showRocketsCallCounter += 1
    }
    
}

class RocketsPresenterTest: XCTestCase {
    
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
    
    func testRocketsPresenterShowRockets() {
        let vc = RocketsMockView()
        let presenter = RocketsPresenter(
            view: vc,
            router: router,
            rockets: []
        )
        vc.presenter = presenter
        presenter.showRockets()
        XCTAssertEqual(vc.showRocketsCallCounter, 1)
    }
    
    func testRocketsPresenterGetRocketPage() throws {
        guard let rocket = try getRocketMock() else {
            XCTFail("Get Rocket instance failed.")
            return
        }
        let vc = RocketsMockView()
        let presenter = RocketsPresenter(
            view: vc,
            router: router,
            rockets: []
        )
        vc.presenter = presenter
        let rocketPage = presenter.getRocketPage(rocket: rocket)
        XCTAssert(rocketPage is RocketPageVC)
    }
    
}
