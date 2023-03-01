//
//  MainPresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/15/23.
//

import Foundation

protocol MainViewProtocol: AnyObject {}

protocol MainPresenterProtocol: AnyObject {
    init(
        view: MainViewProtocol,
        router: MainRouterProtocol,
        rocketService: RocketNetworkServiceProtocol
    )
    func getRockets()
}

final class MainPresenter {
        
    private let rocketService: RocketNetworkServiceProtocol
    weak var view: MainViewProtocol?
    let router: MainRouterProtocol?
        
    init(
        view: MainViewProtocol,
        router: MainRouterProtocol,
        rocketService: RocketNetworkServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.rocketService = rocketService
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func getRockets() {
        rocketService.getRockets(
            onSuccess: { [weak self] (rockets: [Rocket]) in
                DispatchQueue.main.async {
                    self?.router?.showRockets(rockets: rockets)
                }
            },
            onError: { [weak self] error in
                self?.router?.showError {
                    self?.router?.goToRoot()
                }
            }
        )
    }
    
}
