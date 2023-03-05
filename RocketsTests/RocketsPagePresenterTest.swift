//
//  RocketPagePresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/3/23.
//

import XCTest
@testable import Rockets

final class RocketPageViewMock: RocketPageViewProtocol {
    
    var reloadCollectionCounter = 0
    
    func reloadCollection() {
        reloadCollectionCounter += 1
    }
}

final class ImageDownloaderMock: ImageDownloaderProtocol {
    
    static let shared = ImageDownloader()
    
    var downloadCounter = 0
    
    func download(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        downloadCounter += 1
    }
}

final class SettingsRepositoryMock: SettingsRepositoryProtocol {
    
    var saveCounter = 0
    var getCounter = 0
    
    func save(_ settings: [Rockets.Setting], for key: String) {
        saveCounter += 1
    }
    
    func get(for key: String) -> [Rockets.Setting] {
        getCounter += 1
        return [Rockets.Setting(type: .diameter, unit: .feets, selected: 0)]
    }
}

final class RocketsPagePresenterTest: XCTestCase {
    
    let moduleBuilder = ModuleBuilder()
    let navigationController = MockNavigationController()
    var router: MainRouterProtocol!
    var presenter: RocketsPagePresenter!
    var view: RocketPageViewMock!
    var imageDownloader: ImageDownloaderMock!
    var settingsRepository: SettingsRepositoryMock!
    
    override func setUpWithError() throws {
        guard let rocket = try getRocketMock() else {
            XCTFail("Get Rocket instance failed.")
            return
        }
        settingsRepository = SettingsRepositoryMock()
        imageDownloader = ImageDownloaderMock()
        view = RocketPageViewMock()
        router = MainRouter(
            navigationController: navigationController,
            moduleBuilder: moduleBuilder
        )
        presenter = RocketsPagePresenter(
            view: view,
            router: router,
            imageDownloader: imageDownloader,
            settingsRepository: settingsRepository,
            rocket: rocket
        )
    }

    override func tearDown() {
        router = nil
        presenter = nil
        view = nil
    }
    
    func testRocketPagePresenterPresent() {
        presenter.present()
        XCTAssertEqual(view.reloadCollectionCounter, 1)
    }
    
    func testRocketPagePresenterTapOnSettings() {
        presenter.tapOnSettings()
        XCTAssertTrue(navigationController.presentedVC is SettingsVC)
    }
    
    func testRocketPagePresenterTapOnLauches() {
        presenter.tapOnLauches()
        XCTAssertTrue(navigationController.presentedVC is LaunchesVC)
    }
    
    func testRocketPagePredsenterDownLoadImage() {
        presenter.downLoadImage()
        XCTAssertEqual(imageDownloader.downloadCounter, 1)
    }
    
    func testRocketPagePresenterUpdateImage() {
        presenter.sections = [RocketSection(type: .image)]
        presenter.updateImage(with: Data())
        XCTAssertNotEqual(presenter.sections[0].imageData, nil)
        XCTAssertEqual(view.reloadCollectionCounter, 1)
    }
    
    func testRocketPagePresenterGetSettings() {
        presenter.getSettings()
        XCTAssertEqual(settingsRepository.getCounter, 1)
    }
    
    func testRocketPagePresenterGetSpecsItems() {
        let items = presenter.getRocketSpecItems()
        XCTAssertEqual(items.count, 4)
    }
    
    func testRocketPagePresenterUpdateSection() {
        presenter.sections = [RocketSection(type: .image)]
        presenter.updateSection(with: RocketSection(type: .title(text: "test")), at: 0)
        switch presenter.sections[0].type {
        case let .title(text):
            XCTAssertEqual(text, "test")
            break
        case
            .image,
            .subtitle,
            .horizontal,
            .line,
            .button:
            break
        }
    }
    
    func testRocketPagePresenterUpdateSpecs() {
        presenter.sections = [
            RocketSection(type: .title(text: "")),
            RocketSection(type: .title(text: "")),
            RocketSection(type: .horizontal(items: []))
        ]
        presenter.updateSpecs()
        switch presenter.sections[2].type {
        case let .horizontal(items):
            XCTAssertEqual(items.count, 4)
            break
        case
            .title,
            .image,
            .subtitle,
            .line,
            .button:
            break
        }
        XCTAssertEqual(view.reloadCollectionCounter, 1)
    }
}
