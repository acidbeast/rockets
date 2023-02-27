//
//  MainView.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/15/23.
//

import UIKit

final class LoadingView: UIView {
    
    let mainImageView = UIImageView()
    let mainTextLabel = UILabel()
    let loaderView = IndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension LoadingView {
        
    func setup() {
        setupMainImageView()
        setupMainLabelView()
        setupLoaderView()
    }
    
    func setupMainImageView() {
        addSubview(mainImageView)
        mainImageView.image = UIImage(named: "rocket")
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 120),
            mainImageView.heightAnchor.constraint(equalToConstant: 120),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80)
        ])
    }
    
    func setupMainLabelView() {
        addSubview(mainTextLabel)
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.text = "LOADING"
        mainTextLabel.font = UIFont(name: "Avenir Next Regular", size: 18.0)
        mainTextLabel.textColor = UIColor(hex: "#8E8E8F")
        NSLayoutConstraint.activate([
            mainTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainTextLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30)
        ])
    }
    
    func setupLoaderView() {
        addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 30)
        ])
    }
    
}

// MARK: - Animation
extension LoadingView {
    func playAnimation() {
        loaderView.playAnimation()
    }
}
