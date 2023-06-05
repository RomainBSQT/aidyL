//
//  UIColor+System.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation
import UIKit

extension UIColor {
    static func systemColor(_ index: Int) -> UIColor {
        lazy var colors: [UIColor] = [
            .systemRed,
            .systemOrange,
            .systemGreen,
            .systemMint,
            .systemBlue,
            .systemIndigo,
            .systemPurple,
            .systemPink,
            .systemBrown
        ]
        return colors[index % colors.count]
    }
}
