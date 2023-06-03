//
//  ListViewModel.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

enum ListScene {
    struct InitialViewModel {
        let title: String = "Bonsoir"
    }
    
    struct ProfilesViewModel {
        let profiles: [ProfileViewModel]
        
        struct ProfileViewModel: Hashable {
            let firstName: String
            let lastName: String
            let color: UIColor
            
//            let profile: Profile
        }
    }
}
