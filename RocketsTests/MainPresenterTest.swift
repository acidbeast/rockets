//
//  MainPresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/3/23.
//

import XCTest
@testable import Rockets

class RocketServiceMock: RocketNetworkServiceProtocol {
    
    var serviceCallCounter = 0
    
    func getRockets(onSuccess: @escaping ([Rockets.Rocket]) -> Void, onError: @escaping (Error) -> Void) {
        serviceCallCounter += 1
    }
        
}

final class MainPresenterTest: XCTestCase {
    
    let navigationController = MockNavigationController()
    let moduleBuilder = ModuleBuilder()
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
    
    func testMainPresenterGetRockets() {
        let rocketServiceMock = RocketServiceMock()
        let vc = MainVC()
        let presenter = MainPresenter(
            view: vc,
            router: router,
            rocketService: rocketServiceMock
        )
        vc.presenter = presenter
        presenter.getRockets()
        XCTAssertEqual(rocketServiceMock.serviceCallCounter, 1)
    }
    
}
