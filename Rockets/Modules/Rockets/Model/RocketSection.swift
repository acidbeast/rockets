//
//  RocketSection.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/16/23.
//

import UIKit

enum RocketSectionType {
    case image
    case title(text: String)
    case subtitle(text: String)
    case horizontal(items: [RocketSpec])
    case line(text: String, value: String, units: String)
    case button(text: String)
}

struct RocketSection {
    let type: RocketSectionType
    var imageData: Data? = nil
}
