//
//  DetailPresenter.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation
import UIKit

protocol DetailPresenterLogic {
    func start(_ profile: ProfileDisplay)
    func mapSnapshot(_ image: UIImage)
}

final class DetailPresenter: DetailPresenterLogic {
    weak var display: DetailDisplayLogic?
    
    private let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withFractionalSeconds]
        return formatter
    }()
    
    private let dateOutputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
    
    // MARK: - DetailPresenterLogic conformance
    func start(_ profile: ProfileDisplay) {
        let streetAndName = profile.profile.location.street.formatted
        let state = profile.profile.location.state
        let country = profile.profile.location.country
        let address = "📍 \(streetAndName)\n\(state) - \(country)"
        
        let dobFormatted: String = {
            guard let doBDate = formatter.date(from: profile.profile.dOB.date) else { return "" }
            return dateOutputFormatter.string(from: doBDate)
        }()
        let registeredDateFormatted: String = {
            guard let registeredDate = formatter.date(from: profile.profile.registered.date) else { return "" }
            return dateOutputFormatter.string(from: registeredDate)
        }()
        
        display?.initial(DetailScene.InitialViewModel(
            title: profile.profile.name.first,
            color: profile.color,
            name: "\(profile.profile.name.title) \(profile.profile.name.first) \(profile.profile.name.last)",
            nationalityAndGender: "\(profile.profile.nationality.countryFlag)\(profile.profile.gender.symbol)",
            email: profile.profile.email,
            address: address,
            phone: "📞 " + profile.profile.phone,
            cell: "📱 " + profile.profile.cell,
            dOB: "🎂 " + dobFormatted,
            registeredDate: "📒 " + registeredDateFormatted,
            imagePublisher: profile.imageDownloader
        ))
    }
    
    func mapSnapshot(_ image: UIImage) {
        display?.mapSnapshot(DetailScene.MapSnapshotViewModel(image: image))
    }
}

private extension Profile.Street {
    var formatted: String { "\(String(number)) \(name) street" }
}

private extension String {
    var countryFlag: String {
        lazy var countryDict = [
            "AU": "🇦🇺",
            "BR": "🇧🇷",
            "CA": "🇨🇦",
            "CH": "🇨🇭",
            "DE": "🇩🇪",
            "DK": "🇩🇰",
            "ES": "🇪🇸",
            "FI": "🇫🇮",
            "FR": "🇫🇷",
            "GB": "🇬🇧",
            "IE": "🇮🇪",
            "IN": "🇮🇳",
            "IR": "🇮🇷",
            "MX": "🇲🇽",
            "NL": "🇳🇱",
            "NO": "🇳🇴",
            "NZ": "🇳🇿",
            "RS": "🇷🇸",
            "TR": "🇹🇷",
            "UA": "🇺🇦",
            "US": "🇺🇸"
        ]
        return countryDict[self] ?? "🏴‍☠️"
    }
}

private extension Profile.Gender {
    var symbol: String {
        lazy var genderDict: [Profile.Gender : String] = [
            .male: "♂︎",
            .female: "♀︎",
            .nonBinary: "⚨"
        ]
        return genderDict[self]!
    }
}
