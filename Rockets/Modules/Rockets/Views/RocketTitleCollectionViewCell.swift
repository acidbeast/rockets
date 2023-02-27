//
//  RocketTitleCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/8/23.
//

import UIKit
import Foundation

final class RocketTitleCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let settingsButton = UIButton()
    private let settingsButtonImage = UIImage(named: "icon_setting_28")
    
    var onOpenSettings: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension RocketTitleCollectionViewCell {
    func setup() {
        setupContainerView()
        setupSettingsButton()
        setupTitleLabel()
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 32
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -32),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupSettingsButton() {
        containerView.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(settingsButtonImage, for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 28),
            settingsButton.heightAnchor.constraint(equalToConstant: 28),
            settingsButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 48),
            settingsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32)
        ])
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(24)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 48)
        ])
    }
}

// MARK: - Configure
extension RocketTitleCollectionViewCell {
    func configure(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - Reset
extension RocketTitleCollectionViewCell {
    func reset() {
        titleLabel.text = ""
    }
}

// MARK: - Button Handler
private extension RocketTitleCollectionViewCell {
    @objc func openSettings() {
        onOpenSettings?()
    }
}

