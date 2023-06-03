//
//  Profile.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation

struct Profile: Identifiable, Codable {
    
    let id: String = UUID().uuidString
    var gender: Gender { Gender(string: genderRaw) }
    let name: Name

    private let genderRaw: String
    
    enum CodingKeys: String, CodingKey {
        case genderRaw = "gender"
        case name
    }
    
    enum Gender {
        case male
        case female
        case nonBinary
        
        init(string: String) {
            switch string {
            case "male": self = .male
            case "female": self = .female
            default: self = .nonBinary
            }
        }
    }
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool { lhs.id == rhs.id }
}
