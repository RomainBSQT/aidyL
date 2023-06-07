//
//  Set+CancellableCleanup.swift
//  aidyL
//
//  Created by Romain Bousquet on 6/6/2023.
//

import Foundation
import Combine

extension Set where Element == AnyCancellable {
    mutating func cleanup() {
        forEach { $0.cancel() }
        removeAll()
    }
}
