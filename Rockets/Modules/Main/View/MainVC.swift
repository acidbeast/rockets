//
//  MainVC.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/15/23.
//

import UIKit

final class MainVC: UIViewController {
    var presenter: MainPresenter!
    let mainView = LoadingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.getRockets()
    }
    override func viewDidAppear(_ animated: Bool) {
        mainView.playAnimation()
    }
}

extension MainVC: MainViewProtocol {}

extension MainVC {
    func setup() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
