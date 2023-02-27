//
//  Settings.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/12/23.
//

import Foundation

enum SettingUnit: Codable {
    
    case meters
    case feets
    case kilograms
    case pounds
    
    var name: String {
        switch (self) {
        case .meters:
            return "m"
        case .feets:
            return "ft"
        case .kilograms:
            return "kg"
        case .pounds:
            return "lb"
        }
    }
}

enum SettingType: Codable {
    
    case height
    case diameter
    case mass
    case payload
    
    var name: String {
        switch self {
        case .height:
            return "Height"
        case .diameter:
            return "Diameter"
        case .mass:
            return "Mass"
        case .payload:
            return "Payload"
        }
    }
    
    var units: [SettingUnit] {
        switch self {
        case .height, .diameter:
            return [.feets, .meters]
        case .mass, .payload:
            return [.pounds, .kilograms]
        }
    }
    
}

struct Setting: Codable {
    
    let settingType: SettingType
    let settingUnit: SettingUnit
    let selectedIndex: Int
    
    var selectedUnit: SettingUnit {
        return settingType.units[selectedIndex]
    }
    
    enum CodingKeys: CodingKey {
        case settingType
        case settingUnit
        case selectedIndex
    }
    
    init(
        type: SettingType,
        unit: SettingUnit,
        selected: Int
    ) {
        self.settingType = type
        self.settingUnit = unit
        self.selectedIndex = selected
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        settingType = try container.decodeIfPresent(SettingType.self, forKey: .settingType) ?? .height
        settingUnit = try container.decodeIfPresent(SettingUnit.self, forKey: .settingUnit) ?? .meters
        selectedIndex = try container.decodeIfPresent(Int.self, forKey: .selectedIndex) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(settingType, forKey: .settingType)
        try container.encode(settingUnit, forKey: .settingUnit)
        try container.encode(selectedIndex, forKey: .selectedIndex)
    }
    
}

extension Setting: Hashable {}
