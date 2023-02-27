//
//  LaunchTableViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/19/23.
//

import UIKit

final class LaunchTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusImageView = UIImageView()
    private var launchStatus: Bool? = false
    
    func configure(title: String, date: String, status: Bool? = false) {
        titleLabel.text = title
        dateLabel.text = date
        launchStatus = status
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        dateLabel.text = ""
        launchStatus = nil
        statusImageView.image = nil
    }
    
}

// MARK: - Setup
private extension LaunchTableViewCell {
    
    func setup() {
        setupCell()
        setupContainerView()
        setupTitleLabel()
        setupDateLabel()
        setupStatusImageView()
    }
    
    func setupCell() {
        backgroundColor = .black
    }
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(hex: "#212121")
        containerView.layer.cornerRadius = 24
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 110),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
        ])
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(20)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -96),
        ])
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 1
        dateLabel.textColor = UIColor(hex: "#8E8E8F")
        dateLabel.font = dateLabel.font.withSize(16)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -96)
        ])
    }
    
    func setupStatusImageView() {
        if let launchStatus = launchStatus {
            addSubview(statusImageView)
            statusImageView.translatesAutoresizingMaskIntoConstraints = false
            let imageName = launchStatus == true ? "launch_success_32" : "launch_error_32"
            statusImageView.image = UIImage(named: imageName)
            NSLayoutConstraint.activate([
                statusImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                statusImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32)
            ])
        }
    }
    
}
