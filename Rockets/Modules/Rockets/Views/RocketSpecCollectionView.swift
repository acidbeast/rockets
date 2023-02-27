//
//  RocketSpecCollectionView.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/24/23.
//

import UIKit

final class RocketSpecCollectionView: UICollectionView {
    
    var specs = [RocketSpec]()
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        registerCells()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDataSource
extension RocketSpecCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: RocketSpecCollectionViewCell.identifier, for: indexPath) as? RocketSpecCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: specs[indexPath.row])
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketSpecCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 96, height: 96)
    }
}

// MARK: - Setup
private extension RocketSpecCollectionView {

    func setup() {
        setupCollection()
    }
    
    func setupCollection() {
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = true
        isUserInteractionEnabled = true
        alwaysBounceHorizontal = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .black
    }
    
}

// MARK: - Register Cells
private extension RocketSpecCollectionView {

    func registerCells() {
        register(RocketSpecCollectionViewCell.self, forCellWithReuseIdentifier: RocketSpecCollectionViewCell.identifier)
    }
    
}

// MARK: - Configure
extension RocketSpecCollectionView {
    
    func configure(with specs: [RocketSpec]) {
        self.specs = specs
    }
    
}
