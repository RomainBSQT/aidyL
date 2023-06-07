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
    let email: String
    let nationality: String
    let location: Location
    let phone: String
    let cell: String
    let dOB: RemoteDate
    let registered: RemoteDate
    
    let genderRaw: String
    
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
    
    struct Location: Codable {
        let street: Street
        let city: String
        let state: String
        let country: String
        let coordinates: Coordinates
    }
    
    struct Street: Codable {
        let number: Int
        let name: String
    }
    
    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }
    
    struct RemoteDate: Codable {
        let date: String
        let age: Int
    }

    enum CodingKeys: String, CodingKey {
        case genderRaw = "gender"
        case name
        case picture
        case email
        case nationality = "nat"
        case location
        case phone
        case cell
        case dOB = "dob"
        case registered
    }
}

extension Profile: Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool { lhs.id == rhs.id }
}
