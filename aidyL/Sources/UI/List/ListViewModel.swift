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
        let title: String = "Bonsoir"
    }
    
    struct ProfilesViewModel {
        let profiles: [ProfileViewModel]
        
        struct ProfileViewModel: Hashable {
            let id: String
            let firstName: String
            let lastName: String
            let color: UIColor
            
            let imagePublisher: AnyPublisher<UIImage, Never>
            
            static func == (
                lhs: ListScene.ProfilesViewModel.ProfileViewModel,
                rhs: ListScene.ProfilesViewModel.ProfileViewModel
            ) -> Bool {
                lhs.id == rhs.id
            }
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
        }
    }
}
