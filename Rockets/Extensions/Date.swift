//
//  Date.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/21/23.
//

import Foundation

extension Date {
    
    static func format(_ source: String, from: String, to: String) -> String {
        let dateInFormatter = DateFormatter()
        dateInFormatter.dateFormat = from
        let dateOutFormatter = DateFormatter()
        dateOutFormatter.dateFormat = to
        dateInFormatter.date(from: source)
        guard let date = dateInFormatter.date(from: source) else { return "" }
        return dateOutFormatter.string(from: date)
    }
    
}
