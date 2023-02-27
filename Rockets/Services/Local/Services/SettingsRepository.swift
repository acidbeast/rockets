//
//  SettingsRepository.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/13/23.
//

import Foundation

protocol SettingsRepositoryProtocol {
    func save(_ settings: [Setting], for key: String)
    func get(for key: String) -> [Setting]
}

final class SettingsRepository: SettingsRepositoryProtocol  {
    
    private let userDefaults: UserDefaults
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    init (
        userDefaults: UserDefaults = .standard,
        jsonDecoder: JSONDecoder = .init(),
        jsonEncoder: JSONEncoder = .init()
    ) {
        self.userDefaults = userDefaults
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }
    
    func save(_ settings: [Setting], for key: String) {
        guard let data = try? jsonEncoder.encode(settings) else {
            return
        }
        userDefaults.set(data, forKey: key)
    }
    
    func get(for key: String) -> [Setting] {
        guard
            let data = userDefaults.data(forKey: key),
            let settings = try? jsonDecoder.decode([Setting].self, from: data)
        else {
            return [
                Setting(type: .height, unit: .feets, selected: 0),
                Setting(type: .diameter, unit: .feets, selected: 0),
                Setting(type: .mass, unit: .pounds, selected: 0),
                Setting(type: .payload, unit: .pounds, selected: 0)
            ]
        }
        return settings
    }
    
}
