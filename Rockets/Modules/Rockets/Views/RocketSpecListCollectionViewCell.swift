//
//  RocketSpecListCollectionViewCell.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/9/23.
//

import Foundation
import UIKit

final class RocketSpecListCollectionViewCell: UICollectionViewCell {
    
    private let collectionView = RocketSpecCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension RocketSpecListCollectionViewCell {
    
    func setup() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.setCollectionViewLayout(getCollectionViewLayout(), animated: false)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        return layout
    }
    
}


// MARK: - Reset
extension RocketSpecListCollectionViewCell {
    func reset() {}
}

// MARK: - Configure
extension RocketSpecListCollectionViewCell {
    
    func configure(items specs: [RocketSpec]) {
        collectionView.configure(with: specs)
        collectionView.reloadData()
    }
    
}
