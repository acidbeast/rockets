//
//  RocketSubtitleCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/9/23.
//

import Foundation
import UIKit

final class RocketSubtitleCollectionViewCell: UICollectionViewCell {
    
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension RocketSubtitleCollectionViewCell {
    
    func setup() {
        setupTextLabel()
    }
    
    func setupTextLabel() {
        contentView.addSubview(textLabel)
        textLabel.numberOfLines = 0
        textLabel.textColor = .white
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}

// MARK: - Setup
extension RocketSubtitleCollectionViewCell {
    func configure(with text: String) {
        textLabel.text = text.uppercased()
    }
}

// MARK: - Reset
extension RocketSubtitleCollectionViewCell {
    func reset() {
        textLabel.text = ""
    }
}
