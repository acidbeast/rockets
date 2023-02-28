//
//  RocketsPagePresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/17/23.
//

import UIKit

protocol RocketPageViewProtocol: AnyObject {
    func reloadCollection()
}

protocol RocketsPagePresenterProtocol: AnyObject {
    init(
        view: RocketPageViewProtocol,
        router: MainRouterProtocol,
        imageDownloader: ImageDownloader,
        settingsRepository: SettingsRepositoryProtocol,
        rocket: Rocket
    )
    var sections: [RocketSection] { get set }
    func present()
    func tapOnSettings()
    func tapOnLauches()
    func downLoadImage()
    func getSettings()
    func updateSpecs()
}

final class RocketsPagePresenter: RocketsPagePresenterProtocol {
        
    weak var view: RocketPageViewProtocol?
    private let router: MainRouterProtocol?
    private let imageDownloader: ImageDownloader?
    private let settingsRepository: SettingsRepositoryProtocol?
    private let rocket: Rocket
    
    private var settings = [Setting]()
    var sections: [RocketSection] = []
    
    required init(
        view: RocketPageViewProtocol,
        router: MainRouterProtocol,
        imageDownloader: ImageDownloader,
        settingsRepository: SettingsRepositoryProtocol,
        rocket: Rocket
    ) {
        self.view = view
        self.router = router
        self.imageDownloader = imageDownloader
        self.settingsRepository = settingsRepository
        self.rocket = rocket
    }
    
    func present() {
        self.sections = [
            .init(
                type: .image
            ),
            .init(
                type: .title(text: rocket.name)
            ),
            .init(
                type: .horizontal(items: getRocketSpecItems())
            ),
            .init(
                type: .line(
                    text: "First flight",
                    value: rocket.firstFlightFormatted,
                    units: ""
                )
            ),
            .init(
                type: .line(
                    text: "Country",
                    value: rocket.country,
                    units: ""
                )
            ),
            .init(
                type: .line(
                    text: "Launch cost",
                    value: "$\(rocket.costPerLaunchFormatted)",
                    units: ""
                )
            ),
            .init(
                type: .subtitle(text: "First stage")
            ),
            .init(
                type: .line(
                    text: "Engines amount",
                    value: rocket.firstStage.enginesDescription,
                    units: ""
                )
            ),
            .init(
                type: .line(
                    text: "Fuel amount",
                    value: rocket.firstStage.fuelAmountTonsDescription,
                    units: "tons"
                )
            ),
            .init(
                type: .line(
                    text: "Burn time",
                    value: rocket.firstStage.burnTime,
                    units: "sec"
                )
            ),
            .init(
                type: .subtitle(text: "Second stage")
            ),
            .init(
                type: .line(
                    text: "Engines amount",
                    value: rocket.secondStage.enginesDescription,
                    units: ""
                )
            ),
            .init(
                type: .line(
                    text: "Fuel amount",
                    value: rocket.secondStage.fuelAmountTonsDescription,
                    units: "tons"
                )
            ),
            .init(
                type: .line(
                    text: "Burn time",
                    value: rocket.secondStage.burnTime,
                    units: "sec"
                )
            ),
            .init(
                type: .button(text: "View launches")
            )
        ]
        view?.reloadCollection()
    }
            
    func tapOnSettings() {
        router?.showSettings(rocketId: rocket.id) { [weak self] in
            self?.getSettings()
            self?.updateSpecs()
        }
    }
        
    func tapOnLauches() {
        router?.showLauches(
            rocketId: rocket.id,
            rocketName: rocket.name
        )
    }
    
    func downLoadImage() {
        guard let url = URL(string: rocket.flickrImages[0]) else { return }
        imageDownloader?.download(url: url) { [weak self] data, error in
            guard let data = data else { return }
            self?.updateImage(with: data)
        }
    }
    
    func updateImage(with data: Data) {
        var section = RocketSection(type: .image)
        section.imageData = data
        updateSection(with: section, at: 0)
        view?.reloadCollection()
    }

    func getSettings() {
        guard let settings = settingsRepository?.get(for: rocket.id) else { return }
        self.settings = settings
    }
    
    func getRocketSpecItems() -> [RocketSpec] {
        let items: [RocketSpec] = [
            .init(
                setting: settings.first(where: { $0.settingType == .height }),
                height: rocket.height
            ),
            .init(
                setting: settings.first(where: { $0.settingType == .diameter }),
                diameter: rocket.diameter
            ),
            .init(
                setting: settings.first(where: { $0.settingType == .mass }),
                mass: rocket.mass
            ),
            .init(
                setting: settings.first(where: { $0.settingType == .payload }),
                payloadWeights: rocket.payloadWeights
            )
        ]
        return items
    }
    
    func updateSection(with section: RocketSection, at index: Int) {
        self.sections.remove(at: index)
        self.sections.insert(contentsOf: [section], at: index)
    }
    
    func updateSpecs() {
        let section = RocketSection(type: .horizontal(items: getRocketSpecItems()))
        updateSection(with: section, at: 2)
        view?.reloadCollection()
    }
    
}
