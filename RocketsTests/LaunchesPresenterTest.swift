//
//  LaunchesPresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/1/23.
//

import XCTest
@testable import Rockets
@testable import NetworkDispatcher

class LaunchesMockView: LaunchesViewProtocol {
    
    var showTableCounter = 0
    var showEmptyCounter = 0
    
    func setNavigationTitle(with: String) {}
    
    func showTable() {
        showTableCounter += 1
    }
    
    func showEmpty(_ title: String, _ description: String) {
        showEmptyCounter += 1
    }
    
}

class LaunchServiceMock: LaunchNetworkServiceProtocol {
    
    var serviceCallCounter = 0
    
    func getLaunches(onSuccess: @escaping ([Rockets.Launch]) -> Void, onError: @escaping (NetworkError) -> Void) {
        serviceCallCounter += 1
    }
    
}


final class LaunchesPresenterTest: XCTestCase {

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
    
    func testLaunchesPresenterSetTitle() {
        let vc = moduleBuilder.createLaunchesModule(rocketId: "1", rocketName: "Falcon 1", router: router)
        if let presenter = (vc as? LaunchesVC)?.presenter {
            presenter.setTitle()
            XCTAssertEqual(vc.navigationItem.title, "Falcon 1")
        } else {
            XCTFail("Presenter is not available")
        }
    }
    
    func testLaunchesPresenterShowTable() {
        let vc = moduleBuilder.createLaunchesModule(rocketId: "1", rocketName: "Falcon 1", router: router)
        if let presenter = (vc as? LaunchesVC)?.presenter {
            let mockView = LaunchesMockView()
            presenter.view = mockView
            presenter.showTable()
            XCTAssertEqual(mockView.showTableCounter, 1)
        } else {
            XCTFail("Presenter is not available")
        }
    }
    
    func testLaunchesPresenterShowEmpty() {
        let vc = moduleBuilder.createLaunchesModule(rocketId: "1", rocketName: "Falcon 1", router: router)
        if let presenter = (vc as? LaunchesVC)?.presenter {
            let mockView = LaunchesMockView()
            presenter.view = mockView
            presenter.showEmpty()
            XCTAssertEqual(mockView.showEmptyCounter, 1)
        } else {
            XCTFail("Presenter is not available")
        }
    }
    
    
    func testLaunchesPresenterGetLaunches() {
        let launchServiceMock = LaunchServiceMock()
        let vc = LaunchesVC()
        let presenter = LaunchesPresenter(
            view: vc,
            router: router,
            rocketId: "1",
            rocketName: "Falcon 1",
            launchService: launchServiceMock
        )
        presenter.getLaunches()
        XCTAssertEqual(launchServiceMock.serviceCallCounter, 1)
    }

}
