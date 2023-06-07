//
//  DetailViewModel.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation
import UIKit
import Combine

enum DetailScene {
    struct InitialViewModel {
        let addressDescription = "Address".localized
        let phoneDescription = "Phones".localized
        let datesDescription = "Dates".localized
        
        let title: String
        let color: UIColor
        let name: String
        let nationalityAndGender: String
        let email: String
        let address: String
        let phone: String
        let cell: String
        let dOB: String
        let registeredDate: String
        
        let imagePublisher: AnyPublisher<UIImage, Never>
    }
    
    struct MapSnapshotViewModel {
        let image: UIImage
    }
}
