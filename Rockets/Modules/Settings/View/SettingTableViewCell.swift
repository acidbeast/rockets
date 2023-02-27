//
//  SettingTableViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/14/23.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let segmentControl = UISegmentedControl()
    private let nameLabel = UILabel()
    var settingChange: ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        segmentControl.removeAllSegments()
    }
    
}


// MARK: - Setup
private extension SettingTableViewCell {
    
    func setup() {
        setupCell()
        addSubviews()
        setupContainerView()
        setupSegmentControl()
        setupNameLabel()
    }
    
    func setupCell() {
        backgroundColor = .black
    }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        [segmentControl, nameLabel].forEach(containerView.addSubview)
    }
    
    func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 40),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28)
        ])
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor(hex: "#F6F6F6")
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
        ])
    }
    
    func setupSegmentControl() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#8E8E8F")]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#121212")]
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.backgroundColor = UIColor(hex: "#212121")
        segmentControl.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
        segmentControl.setTitleTextAttributes(selectedTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        NSLayoutConstraint.activate([
            segmentControl.widthAnchor.constraint(equalToConstant: 120),
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
            segmentControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
}

// MARK: - Configure
extension SettingTableViewCell {
    
    func configure(with setting: Setting, settingChanged: @escaping (Setting, Int) -> Void) {
        for (index,unit) in setting.settingType.units.enumerated() {
            segmentControl.insertSegment(withTitle: unit.name, at: index, animated: false)
        }
        nameLabel.text = setting.settingType.name
        segmentControl.selectedSegmentIndex = setting.selectedIndex
        segmentControl.addAction(UIAction { [segmentControl] _ in
            settingChanged(setting, segmentControl.selectedSegmentIndex)
        }, for: .valueChanged)
    }
    
}
