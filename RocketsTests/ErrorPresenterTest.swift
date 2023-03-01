//
//  ErrorPresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/1/23.
//

import XCTest
@testable import Rockets

final class ErrorPresenterTest: XCTestCase {

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

    func testErrorPresenterButtonActionCall() throws {
        var counter = 0
        let vc = moduleBuilder.createErrorModule(
            buttonAction: {
                counter += 1
            },
            router: router
        )
        (vc as? ErrorVC)?.presenter.runAction()
        XCTAssertEqual(counter, 1)
    }
    
}
