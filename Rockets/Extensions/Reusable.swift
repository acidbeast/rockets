//
//  Reusable.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/14/23.
//

import Foundation
import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}
