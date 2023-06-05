//
//  String+Localized.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
