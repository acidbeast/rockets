//
//  ErrorPresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/16/23.
//

import UIKit

protocol ErrorViewProtocol: AnyObject {
    var presenter: ErrorPresenter! { get set }
}

protocol ErrorPresenterProtocol: AnyObject {
    init(
        view: ErrorViewProtocol,
        router: MainRouterProtocol,
        buttonAction: (()-> Void)?
    )
    func runAction()
}

final class ErrorPresenter: ErrorPresenterProtocol {

    weak var view: ErrorViewProtocol?
    let router: MainRouterProtocol?
    var buttonAction: (() -> Void)?

    init(
        view: ErrorViewProtocol,
        router: MainRouterProtocol,
        buttonAction: (() -> Void)?
    ) {
        self.view = view
        self.router = router
        self.buttonAction = buttonAction
    }
    
    func runAction() {
        buttonAction?()
    }
}
