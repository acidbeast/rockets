//
//  SceneDelegate.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let navigationController = UINavigationController()
        let moduleBuilder = ModuleBuilder()
        let router = MainRouter(
            navigationController: navigationController,
            moduleBuilder: moduleBuilder
        )
        router.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

