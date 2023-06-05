//
//  UIEdgeInsets+Convenience.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

extension UIEdgeInsets {
    static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
