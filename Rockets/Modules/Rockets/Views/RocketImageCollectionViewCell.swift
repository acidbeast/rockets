//
//  RocketImageCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/19/23.
//

import UIKit

final class RocketImageCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup
private extension RocketImageCollectionViewCell {
    
    func setup() {
        setupContentView()
        setupImageView()
    }
    
    func setupContentView() {
        contentView.backgroundColor = .gray
    }
    
    func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        imageView.isHidden = true
    }
}

extension RocketImageCollectionViewCell {
    func setImage(with data: Data) {
        if let image = UIImage.init(data: data) {
            imageView.image = image
            imageView.isHidden = false
        }
    }
}
