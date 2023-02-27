//
//  EmptyView.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/21/23.
//

import UIKit

final class EmptyView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
extension EmptyView {
    
    func setup() {
        setupImageView()
        setupTitleLabelView()
        setupDescriptionView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.image = UIImage(named: "rocket")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80)
        ])
    }
    
    func setupTitleLabelView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Avenir Next Regular", size: 18.0)
        titleLabel.textColor = UIColor(hex: "#8E8E8F")
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        ])
    }
    
    func setupDescriptionView() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 14.0)
        descriptionLabel.textColor = UIColor(hex: "#777777")
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
        ])
    }
    
}

// MARK: - Configure
extension EmptyView {
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
