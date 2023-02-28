//
//  RocketsPresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/23/23.
//

import UIKit

protocol RocketsViewProtocol: AnyObject {
    func showRockets()
}

protocol RocketsPresenterProtocol: AnyObject {
    init(
        view: RocketsViewProtocol,
        router: MainRouterProtocol,
        rockets: [Rocket]
    )
    var rockets: [Rocket] { get set }
    func showRockets()
    func getRocketPage(rocket: Rocket) -> UIViewController
}

final class RocketsPresenter: RocketsPresenterProtocol {

    weak var view: RocketsViewProtocol?
    let router: MainRouterProtocol?
    var rockets: [Rocket] = [Rocket]()
    
    required init(
        view: RocketsViewProtocol,
        router: MainRouterProtocol,
        rockets: [Rocket]
    ) {
        self.view = view
        self.router = router
        self.rockets = rockets
    }
    
    func showRockets() {
        view?.showRockets()
    }
    
    func getRocketPage(rocket: Rocket) -> UIViewController {
        return router?.getRocketPage(rocket: rocket) ?? UIViewController()
    }

}
