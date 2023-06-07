//
//  ProfileDisplay+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import Foundation
import Combine
import UIKit

extension ProfileDisplay {
    static func mock() -> ProfileDisplay {
        return ProfileDisplay(
            profile: .mock(),
            color: .white,
            imageDownloader: Just(UIImage()).eraseToAnyPublisher()
        )
    }
}
