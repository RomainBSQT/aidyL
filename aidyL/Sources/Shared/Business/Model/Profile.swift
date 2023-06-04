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
    let picture: Picture

    private let genderRaw: String
    
    enum CodingKeys: String, CodingKey {
        case genderRaw = "gender"
        case name
        case picture
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
    
    struct Picture: Codable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool { lhs.id == rhs.id }
}
