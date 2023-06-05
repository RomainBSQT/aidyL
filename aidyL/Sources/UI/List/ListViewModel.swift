//
//  ListViewModel.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit
import Combine

enum ListScene {
    struct InitialViewModel {
        let title: String = "Profiles".localized
    }
    
    struct ProfilesViewModel {
        let profiles: [ProfileViewModel]
        
        struct ProfileViewModel {
            let name: String
            let email: String
            let color: UIColor
            
            let imagePublisher: AnyPublisher<UIImage, Never>
        }
    }
}
