//
//  RouterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/1/23.
//

import XCTest
@testable import Rockets

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    var popedVC: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag)
    }
    override func popViewController(animated: Bool) -> UIViewController? {
        self.popedVC = viewControllers.last
        return nil
    }
}

final class RouterTest: XCTestCase {

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
    
    func testRouterStart() throws {
        router.start()
        XCTAssertTrue(navigationController.viewControllers[0] is MainVC)
    }
    
    func testRouterShowError() throws {
        router.showError(buttonAction: nil)
        XCTAssertTrue(navigationController.presentedVC is ErrorVC)
    }
    
    func testRouterShowRockets() throws {
        router.showRockets(rockets: [])
        XCTAssertTrue(navigationController.presentedVC is RocketsVC)
    }
    
    func testRouterGetRocketPage() throws {
        guard let rocket = try getRocketMock() else {
            XCTFail("Get Rocket instance failed.")
            return
        }
        let vc = router.getRocketPage(rocket: rocket)
        XCTAssertTrue(vc is RocketPageVC)
    }
    
    func testRouterShowSettings() {
        router.showSettings(rocketId: "", onClose: nil)
        XCTAssertTrue(navigationController.presentedVC is SettingsVC)
    }

    func testRouterShowLaunches() {
        router.showLauches(rocketId: "", rocketName: "")
        XCTAssertTrue(navigationController.presentedVC is LaunchesVC)
    }
    
    func testRouterGoToRoot() {
        router.start()
        router.showRockets(rockets: [])
        router.goToRoot()
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func testRouterGoBack() {
        router.start()
        router.showRockets(rockets: [])
        router.showLauches(rocketId: "", rocketName: "")
        router.goBack()
        XCTAssertTrue(navigationController.popedVC is LaunchesVC)
    }
    
}
