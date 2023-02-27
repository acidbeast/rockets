//
//  DependencyProvider.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/23/23.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMainModule(router: MainRouterProtocol) -> UIViewController
    func createErrorModule(
        buttonAction: (() -> Void)?,
        router: MainRouterProtocol
    ) -> UIViewController
    func createSettingModule(
        rocketId: String,
        router: MainRouterProtocol,
        onClose: (() ->  Void)?
    ) -> UIViewController
    func createRocketsModule(
        rockets: [Rocket],
        router: MainRouterProtocol
    ) -> UIViewController
    func createRocketPageModule(
        rocket: Rocket,
        router: MainRouterProtocol
    ) -> UIViewController
    func createLaunchesModule(
        rocketId: String,
        rocketName: String,
        router: MainRouterProtocol
    ) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createMainModule(router: MainRouterProtocol) -> UIViewController {
        let vc = MainVC()
        let presenter = MainPresenter(
            view: vc,
            router: router,
            rocketService: NetworkService.rocketService
        )
        vc.presenter = presenter
        return vc
    }
    
    func createErrorModule(
        buttonAction: (() -> Void)? = nil,
        router: MainRouterProtocol
    ) -> UIViewController {
        let vc = ErrorVC()
        let presenter = ErrorPresenter(
            view: vc,
            router: router,
            buttonAction: buttonAction
        )
        vc.presenter = presenter
        return vc
    }
    
    func createRocketsModule(
        rockets: [Rocket],
        router: MainRouterProtocol
    ) -> UIViewController {
        let vc = RocketsVC()
        let presenter = RocketsPresenter(
            view: vc,
            router: router,
            rockets: rockets
        )
        vc.presenter = presenter
        return vc
    }
    
    func createRocketPageModule(
        rocket: Rocket,
        router: MainRouterProtocol
    ) -> UIViewController {
        let vc = RocketPageVC()
        let presenter = RocketsPagePresenter(
            view: vc,
            router: router,
            imageDownloader: .shared,
            settingsRepository: LocalService.settingsRepository,
            rocket: rocket
        )
        vc.presenter = presenter
        return vc
    }

    func createSettingModule(
        rocketId: String,
        router: MainRouterProtocol,
        onClose: (() ->  Void)?
    ) -> UIViewController {
        let vc = SettingsVC()
        let presenter = SettingsPresenter(
            view: vc,
            router: router,
            settingsRepository: LocalService.settingsRepository,
            rocketId: rocketId,
            onClose: onClose
        )
        vc.presenter = presenter
        return vc
    }
    
    func createLaunchesModule(
        rocketId: String,
        rocketName: String,
        router: MainRouterProtocol
    ) -> UIViewController {
        let vc = LaunchesVC()
        let presenter = LaunchesPresenter(
            view: vc,
            router: router,
            rocketId: rocketId,
            rocketName: rocketName,
            launchService: NetworkService.launchService
        )
        vc.presenter = presenter
        return vc
    }
    
}
