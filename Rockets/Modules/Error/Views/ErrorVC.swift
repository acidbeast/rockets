//
//  ErrorVC.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/16/23.
//

import UIKit

final class ErrorVC: UIViewController {
    
    let imageView = UIImageView()
    let titleLabelView = UILabel()
    let actionButtonView = UIButton()
    
    var presenter: ErrorPresenter!
    
    override func viewDidLoad () {
        super.viewDidLoad()
        setup()
    }
}

extension ErrorVC: ErrorViewProtocol {}

private extension ErrorVC {
    
    func setup() {
        self.navigationController?.isNavigationBarHidden = true
        setupImageView()
        setupTitleLabel()
        setupButton()
    }

    func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rocket")
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabelView)
        titleLabelView.text = "NETWORK ERROR"
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelView.textColor = UIColor(hex: "#C40000")
        titleLabelView.font = UIFont(name: "Avenir Next Regular", size: 18)
        titleLabelView.textAlignment = .center
        titleLabelView.numberOfLines = 1
        NSLayoutConstraint.activate([
            titleLabelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    func setupButton() {
        view.addSubview(actionButtonView)
        actionButtonView.translatesAutoresizingMaskIntoConstraints = false
        actionButtonView.setTitle("TRY AGAIN", for: .normal)
        actionButtonView.backgroundColor = UIColor(hex: "#8E8E8F")
        actionButtonView.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            actionButtonView.topAnchor.constraint(equalTo: titleLabelView.bottomAnchor, constant: 30),
            actionButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButtonView.widthAnchor.constraint(equalToConstant: 140),
            actionButtonView.heightAnchor.constraint(equalToConstant: 48)
        ])
        actionButtonView.addTarget(self, action: #selector(actionButtonHandler), for: .touchUpInside)
    }
    
}

private extension ErrorVC {
    
    @objc func actionButtonHandler() {
        presenter?.runAction()
    }
    
}
