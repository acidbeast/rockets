//
//  UIColor+Hex.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 2/15/23.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var trimmedString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if trimmedString.hasPrefix("#") {
            trimmedString.remove(at: trimmedString.startIndex)
        }
        if trimmedString.count != 6 {
            return nil
        }
        var rgbValue: UInt64 = 0
        Scanner(string: trimmedString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

}
