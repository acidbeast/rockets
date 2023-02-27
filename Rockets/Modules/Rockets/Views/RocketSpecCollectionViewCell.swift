//
//  RocketSpecCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/24/23.
//

import UIKit

final class RocketSpecCollectionViewCell: UICollectionViewCell {
    
    let valueLabel = UILabel()
    let unitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension RocketSpecCollectionViewCell {
    
    func setup() {
        setupCell()
        setupValueLabel()
        setupUnitLabel()
    }
    
    func setupCell() {
        backgroundColor = UIColor(hex: "#212121")
        layer.cornerRadius = 32
    }
    
    func setupValueLabel() {
        contentView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.numberOfLines = 1
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func setupUnitLabel() {
        contentView.addSubview(unitLabel)
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.numberOfLines = 1
        unitLabel.font = UIFont.systemFont(ofSize: 13)
        unitLabel.textColor = UIColor(hex: "#8E8E8F")
        unitLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            unitLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            unitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            unitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    
}

// MARK: - Configure
extension RocketSpecCollectionViewCell {
    
    func configure(with spec: RocketSpec) {
        guard let name = spec.setting?.settingType.name else { return }
        guard let specName = spec.setting?.settingUnit.name else { return }
        valueLabel.text = getValue(from: spec)
        unitLabel.text = "\(name), \(specName.lowercased())"
    }
        
}

// MARK: - getValue
private extension RocketSpecCollectionViewCell {
    
    func getValue(from spec: RocketSpec) -> String {
        switch spec.setting?.settingType {
        case .height:
            return spec.heightValue
        case .diameter:
            return spec.diameterValue
        case .mass:
            return spec.massValue
        case .payload:
            return spec.payloadValue
        case .none:
            return ""
        }
    }
    
}
