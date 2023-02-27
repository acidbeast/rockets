//
//  Router.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/3/23.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol MainRouterProtocol: RouterProtocol {
    func start()
    func showError(buttonAction: (() -> Void)?)
    func showRockets(rockets: [Rocket])
    func getRocketPage(rocket: Rocket) -> UIViewController
    func showSettings(rocketId: String, onClose: (() ->  Void)?)
    func showLauches(rocketId: String, rocketName: String)
    func goToRoot()
    func goBack()
}

class MainRouter: MainRouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(
        navigationController: UINavigationController?,
        moduleBuilder: ModuleBuilderProtocol?
    ) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
        setupNavigationBarApperance()
    }
    
    func setupNavigationBarApperance() {
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = .none
        appearance.titleTextAttributes = textAttributes
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        guard let mainVC = moduleBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [mainVC]
    }
    
    func showError(buttonAction: (() -> Void)? = nil) {
        guard let navigationController = navigationController else { return  }
        guard let errorVC = moduleBuilder?.createErrorModule(buttonAction: buttonAction, router: self) else { return }
        navigationController.pushViewController(errorVC, animated: false)
    }
    
    func showRockets(rockets: [Rocket]) {
        guard let navigationController = navigationController else { return }
        guard let rocketsVC = moduleBuilder?.createRocketsModule(rockets: rockets, router: self) else { return }
        navigationController.pushViewController(rocketsVC, animated: false)
    }
    
    func getRocketPage(rocket: Rocket) -> UIViewController {
        guard let rocketPageVC = moduleBuilder?.createRocketPageModule(rocket: rocket, router: self) else { return UIViewController() }
        return rocketPageVC
    }
        
    func showSettings(rocketId: String, onClose: (() ->  Void)?) {
        guard let navigationController = navigationController else { return }
        guard let settingVC = moduleBuilder?.createSettingModule(
            rocketId: rocketId,
            router: self,
            onClose: onClose
        ) else { return }
        navigationController.present(settingVC, animated: true)
    }
    
    func showLauches(rocketId: String, rocketName: String) {
        guard let navigationController = navigationController else { return }
        guard let lauchesVC = moduleBuilder?.createLaunchesModule(
            rocketId: rocketId,
            rocketName: rocketName,
            router: self
        ) else { return }
        navigationController.pushViewController(lauchesVC, animated: false)
    }
    
    func goToRoot() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
    
    func goBack() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
