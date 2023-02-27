//
//  RocketLineCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/8/23.
//

import Foundation
import UIKit

final class RocketLineCollectionViewCell: UICollectionViewCell {
    
    private let textLabel = UILabel()
    private let valueLabel = UILabel()
    private let unitLabel = UILabel()
    private var valueLabelTrailing: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension RocketLineCollectionViewCell {
    
    func setup() {
        setupTextLabel()
        setupUnitLabel()
        setupValueLabel()
    }
    
    func setupTextLabel() {
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .lightGray
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setupUnitLabel() {
        contentView.addSubview(unitLabel)
        unitLabel.textColor = .gray
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            unitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    func setupValueLabel() {
        contentView.addSubview(valueLabel)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            valueLabel.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor, constant: -8),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}

// MARK: - Configure
extension RocketLineCollectionViewCell {
    func configure(with values: (String, String, String)) {
        textLabel.text = values.0
        valueLabel.text = values.1
        if values.2.count > 0 {
            unitLabel.text = values.2
            valueLabelTrailing = valueLabel.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor, constant: -8)
        } else {
            unitLabel.isHidden = true
            valueLabelTrailing = valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        }
        valueLabelTrailing?.isActive = true
    }
}

// MARK: - Reset
extension RocketLineCollectionViewCell {
    func reset() {
        textLabel.text = ""
        valueLabel.text = ""
        unitLabel.text = ""
        unitLabel.isHidden = false
        valueLabelTrailing?.isActive = false
    }
}

