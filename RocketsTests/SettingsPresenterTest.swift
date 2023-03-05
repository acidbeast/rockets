//
//  SettingsPresenterTest.swift
//  RocketsTests
//
//  Created by Dmitry Shlepkin on 3/5/23.
//

import XCTest
@testable import Rockets

final class SettingsViewMock: SettingsViewProtocol {
    
    var reloadTableCounter = 0
    
    func reloadTable() {
        reloadTableCounter += 1
    }

}

class SettingsPresenterTest: XCTestCase {
    
    let moduleBuilder = ModuleBuilder()
    let navigationController = UINavigationController()
    var router: MainRouterProtocol!
    var settingsRepository: SettingsRepositoryMock!
    var presenter: SettingsPresenter!
    var view: SettingsViewMock!
    var onCloseCounter = 0
    
    override func setUpWithError() throws {
        router = MainRouter(
            navigationController: navigationController,
            moduleBuilder: moduleBuilder
        )
        view = SettingsViewMock()
        settingsRepository = SettingsRepositoryMock()
        presenter = SettingsPresenter(
            view: view,
            router: router,
            settingsRepository: settingsRepository,
            rocketId: "",
            onClose: {
                self.onCloseCounter += 1
            }
        )
    }

    override func tearDown() {
        router = nil
        onCloseCounter = 0
    }
    
    func testSettingsPresenterGetSettings() {
        presenter.getSettings()
        XCTAssertEqual(presenter.settings.count, 1)
        XCTAssertEqual(view.reloadTableCounter, 1)
    }
    
    func testSettingsPresenterChange() {
        let setting = Setting(type: .diameter, unit: .meters, selected: 1)
        presenter.getSettings()
        presenter.change(setting, 1)
        XCTAssertEqual(presenter.settings[0].selectedIndex, 1)
        XCTAssertEqual(settingsRepository.saveCounter, 1)
    }
    
    func testSettingsPresenterSave() {
        presenter.save()
        XCTAssertEqual(settingsRepository.saveCounter, 1)
    }
    
    func testSettingsPresenterClose() {
        presenter.close()
        XCTAssertEqual(onCloseCounter, 1)
    }
    
}
