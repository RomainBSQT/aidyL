//
//  UIImageView+Download.swift
//  aidyL
//
//  Created by Romain Bousquet on 4/6/2023.
//

import Foundation
import Combine
import UIKit

extension UIImageView {
    func downloadImage(publisher: AnyPublisher<UIImage, Never>) -> AnyCancellable {
        return publisher.sink { image in
            self.image = image
        }
    }
}
