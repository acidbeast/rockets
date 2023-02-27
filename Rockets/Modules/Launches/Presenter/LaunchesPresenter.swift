//
//  LaunchesPresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/17/23.
//

import Foundation

protocol LaunchesViewProtocol: AnyObject {
    func setNavigationTitle(with: String)
    func showTable(launches: [Launch])
    func showEmpty(_ title: String, _ description: String)
}

protocol LaunchesPresenterProtocol: AnyObject {
    init(
        view: LaunchesViewProtocol,
        router: MainRouterProtocol,
        rocketId: String,
        rocketName: String,
        launchService: LaunchNetworkService
    )
    func getLaunches()
    func setTitle()
    func showTable(with launches: [Launch])
    func showEmpty()
}

final class LaunchesPresenter: LaunchesPresenterProtocol {
     
    weak var view: LaunchesViewProtocol?
    let router: MainRouterProtocol!
    private let rocketId: String
    private let rocketName: String
    private var launches = [Launch]()
    private let launchService: LaunchNetworkService
    
    init(
        view: LaunchesViewProtocol,
        router: MainRouterProtocol,
        rocketId: String,
        rocketName: String,
        launchService: LaunchNetworkService
    ) {
        self.view = view
        self.router = router
        self.rocketId = rocketId
        self.rocketName = rocketName
        self.launchService = launchService
    }
    
    func getLaunches() {
        launchService.getLaunches(
            onSuccess: { [weak self] (launches: [Launch]) in
                let launchesForRocket = launches.filter { $0.rocket == self?.rocketId }
                if launchesForRocket.count > 0 {
                    self?.showTable(with: launchesForRocket)
                } else {
                    self?.showEmpty()
                }
            }, onError: { [weak self] error in
                self?.router?.showError {
                    self?.router?.goBack()
                }
            })
    }
    
    func setTitle() {
        view?.setNavigationTitle(with: rocketName)
    }
    
    func showTable(with launches: [Launch]) {
        view?.showTable(launches: launches)
    }
    
    func showEmpty() {
        view?.showEmpty("NO LAUNCHES DATA", "Please, try later!")
    }
    
}
