//
//  Profile+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import Foundation

extension Profile {
    init(latitude: String, longitude: String) {
        self.name = Name(title: "", first: "", last: "")
        self.picture = Picture(large: .mock(), medium: .mock(), thumbnail: .mock())
        self.email = ""
        self.nationality = ""
        self.location = Location(street: Street(number: 0, name: ""), city: "", state: "", country: "",
                                 coordinates: Coordinates(latitude: latitude, longitude: longitude)
        )
        self.phone = ""
        self.cell = ""
        self.dOB = RemoteDate(date: "", age: 0)
        self.registered = RemoteDate(date: "", age: 0)
        self.genderRaw = "male"
    }
    
    static func mock(latitude: String = "40", longitude: String = "40") -> Profile {
        return Profile(latitude: latitude, longitude: longitude)
    }
}

extension URL {
    static func mock() -> URL {
        return URL(string: "http://google.com")!
    }
}
