//
//  UITableViewCell+Reuse.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String { String(describing: self) }
}

extension UITableViewCell: Identifiable {}
