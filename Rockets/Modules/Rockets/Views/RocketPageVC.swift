//
//  RocketPageVC.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/13/23.
//

import UIKit

extension RocketPageVC: RocketPageViewProtocol {}

final class RocketPageVC: UIViewController {
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var sections = [RocketSection]()
    var presenter: RocketsPagePresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCells()
        presenter.downLoadImage()
        presenter.getSettings()
        presenter.present()
    }
}

extension RocketPageVC {
    private func setup() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func present(_ sections: [RocketSection]) {
        self.sections = sections
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - RegisterCells
private extension RocketPageVC {
    
    func registerCell(with cellClass: AnyClass) {
        let identifier = String(describing: cellClass.self)
        collectionView.register(cellClass.self, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCells() {
        registerCell(with: RocketButtonCollectionViewCell.self)
        registerCell(with: RocketImageCollectionViewCell.self)
        registerCell(with: RocketTitleCollectionViewCell.self)
        registerCell(with: RocketLineCollectionViewCell.self)
        registerCell(with: RocketSubtitleCollectionViewCell.self)
        registerCell(with: RocketSpecListCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension RocketPageVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = sections[indexPath.section].type
        let imageData = sections[indexPath.section].imageData
        switch item {
        case .image:
            return createRocketImageCollectionViewCell(indexPath, imageData)
        case let .title(text):
            return createRocketTitleCollectionViewCell(indexPath, text)
        case let .line(text, value, units):
            return createRocketLineCollectionViewCell(indexPath, (text, value, units))
        case let .subtitle(text):
            return createRocketSubtitleCollectionViewCell(indexPath, text)
        case let .horizontal(items):
            return createRocketHorizontalCollectionViewCell(indexPath, items)
        case let .button(text):
            return createRocketButtonCollectionViewCell(indexPath, text)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RocketPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sections[indexPath.section].type
        switch section {
        case .title:
            return .init(
                width: UIScreen.main.bounds.width,
                height: 80
            )
        case .line, .subtitle:
            return .init(
                width: UIScreen.main.bounds.width,
                height: 40
            )
        case .image:
            return .init(
                width: UIScreen.main.bounds.width,
                height: 280
            )
        case .button:
            return .init(
                width: UIScreen.main.bounds.width,
                height: 120
            )
        case .horizontal:
            return .init(
                width: UIScreen.main.bounds.width,
                height: 128
            )
        }
    }
}


// MARK: - Create Cells
private extension RocketPageVC {
    
    func createRocketImageCollectionViewCell(
        _ indexPath: IndexPath,
        _ imageData: Data?
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketImageCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketImageCollectionViewCell else { return UICollectionViewCell() }
        if let imageData = imageData {
            cell.setImage(with: imageData)
        }
        return cell
    }
    
    func createRocketTitleCollectionViewCell(
        _ indexPath: IndexPath,
        _ text: String
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketTitleCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketTitleCollectionViewCell else { return UICollectionViewCell() }
        cell.reset()
        cell.configure(with: text)
        cell.onOpenSettings = { [weak self] in
            self?.presenter.tapOnSettings()
        }
        return cell
    }
    
    func createRocketLineCollectionViewCell(
        _ indexPath: IndexPath,
        _ values: (String, String, String)
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketLineCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketLineCollectionViewCell else { return UICollectionViewCell() }
        cell.reset()
        cell.configure(with: values)
        return cell
    }
    
    func createRocketSubtitleCollectionViewCell(
        _ indexPath: IndexPath,
        _ text: String
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketSubtitleCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketSubtitleCollectionViewCell else { return UICollectionViewCell() }
        cell.reset()
        cell.configure(with: text)
        return cell
    }
    
    func createRocketButtonCollectionViewCell(
        _ indexPath: IndexPath,
        _ text: String
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketButtonCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.reset()
        cell.configure(with: text)
        cell.onOpenLaunches = { [weak self] in
            self?.presenter.tapOnLauches()
        }
        return cell
    }
    
    func createRocketHorizontalCollectionViewCell(
        _ indexPath: IndexPath,
        _ items: [RocketSpec]
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketSpecListCollectionViewCell.identifier,
            for: indexPath
        ) as? RocketSpecListCollectionViewCell else { return UICollectionViewCell() }
        cell.reset()
        cell.configure(items: items)
        return cell
    }
    
}

// MARK: - Update Section
extension RocketPageVC {
    
    func updateSection(with section: RocketSection, at index: Int) {
        DispatchQueue.main.async {
            self.sections.remove(at: index)
            self.sections.insert(contentsOf: [section], at: index)
            self.collectionView.reloadData()
        }
    }
    
}
