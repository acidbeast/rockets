//
//  RocketButtonCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/16/23.
//

import UIKit

final class RocketButtonCollectionViewCell: UICollectionViewCell {
    
    private let button = UIButton()
    var onOpenLaunches: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension RocketButtonCollectionViewCell {
    
    @objc func openLaunches() {
        onOpenLaunches?()
    }
    
    func setup() {
        setupButton()
    }
    
    func setupButton() {
        contentView.addSubview(button)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .gray //#212121
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 56),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
        button.addTarget(self, action: #selector(openLaunches), for: .touchUpInside)
    }
    
}

// MARK: - Reset
extension RocketButtonCollectionViewCell {
    func reset() {
        button.setTitle("", for: .normal)
    }
}

// MARK: - Configure
extension RocketButtonCollectionViewCell {
    func configure(with text: String) {
        button.setTitle(text, for: .normal)
    }
}
