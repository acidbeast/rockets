//
//  SettingsPresenter.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/13/23.
//

import Foundation
 
protocol SettingsViewProtocol: AnyObject {
    func reloadTable()
}

protocol SettingsPresenterProtocol: AnyObject {
    init(
        view: SettingsViewProtocol,
        router: MainRouterProtocol,
        settingsRepository: SettingsRepositoryProtocol,
        rocketId: String,
        onClose: (() -> Void)?
    )
    var settings: [Setting] { get set }
    func getSettings()
    func change(_ setting: Setting, _ selectedIndex: Int)
    func save()
    func close()
}

final class SettingsPresenter {
    
    weak var view: SettingsViewProtocol?
    private let router: MainRouterProtocol?
    private let settingsRepository: SettingsRepositoryProtocol?
    private let rocketId: String
    private var onClose: (() ->  Void)?
    
    var settings = [Setting]()
        
    init(
        view: SettingsViewProtocol,
        router: MainRouterProtocol,
        settingsRepository: SettingsRepositoryProtocol,
        rocketId: String,
        onClose: (() -> Void)?
    ) {
        self.view = view
        self.router = router
        self.settingsRepository = settingsRepository
        self.rocketId = rocketId
        self.onClose = onClose
    }
        
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func getSettings() {
        guard let savedSettings = settingsRepository?.get(for: rocketId) else { return }
        settings = savedSettings
        view?.reloadTable()
    }
     
    func change(_ oldSetting: Setting, _ selectedIndex: Int) {
        let newSetting = Setting(
            type: oldSetting.settingType,
            unit: oldSetting.settingType.units[selectedIndex],
            selected: selectedIndex
        )
        guard let changedIndex = settings.firstIndex(where: { $0.settingType == newSetting.settingType }) else {
            return
        }
        settings.remove(at: changedIndex)
        settings.insert(newSetting, at: changedIndex)
        save()
    }
    
    func save() {
        settingsRepository?.save(settings, for: rocketId)
    }
    
    func close() {
        onClose?()
    }
    
}
