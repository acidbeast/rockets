//
//  RocketSpec.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/24/23.
//

struct RocketSpec {
    var setting: Setting? = nil
    var height: Rocket.Diameter? = nil
    var diameter: Rocket.Diameter? = nil
    var mass: Rocket.Mass? = nil
    var payloadWeights: [Rocket.PayloadWeight]? = nil
    
    var heightValue: String {
        guard let height = height else { return "" }
        guard let unit = setting?.settingUnit else { return "" }
        if unit == .meters {
            return String(height.meters ?? 0)
        }
        if unit == .feets {
            return String(height.feet ?? 0)
        }
        return ""
    }
    
    var diameterValue: String {
        guard let diameter = diameter else { return "" }
        guard let unit = setting?.settingUnit else { return "" }
        if unit == .meters {
            return String(diameter.meters ?? 0)
        }
        if unit == .feets {
            return String(diameter.feet ?? 0)
        }
        return ""
    }
    
    var massValue: String {
        guard let mass = mass else { return "" }
        guard let unit = setting?.settingUnit else { return "" }
        if unit == .kilograms {
            return String(mass.kg)
        }
        if unit == .pounds {
            return String(mass.lb)
        }
        return ""
    }
    
    var payloadValue: String {
        guard let payload = payloadWeights else { return "" }
        guard let unit = setting?.settingUnit else { return "" }
        if payload.count == 0 { return "" }
        if unit == .kilograms {
            return String(payload[0].kg)
        }
        if unit == .pounds {
            return String(payload[0].lb)
        }
        return ""
    }
}
