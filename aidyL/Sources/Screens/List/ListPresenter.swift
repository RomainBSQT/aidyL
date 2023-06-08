//
//  ListPresenter.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit
import Combine

protocol ListPresenterLogic {
    func start()
    func present(_ profiles: [ProfileDisplay])
    func error(_ error: APIError)
    func showDetail(profile: ProfileDisplay)
}

final class ListPresenter: ListPresenterLogic {
    weak var display: ListDisplayLogic?
    
    // MARK: - ListPresenterLogic conformance
    func start() {
        display?.initial(ListScene.InitialViewModel())
    }
    
    func present(_ profiles: [ProfileDisplay]) {
        display?.profiles(ListScene.ProfilesViewModel(profiles: profiles.mappedToViewModels))
    }
    
    func error(_ error: APIError) {
        display?.error(ListScene.ErrorViewModel(
            title: error.title,
            message: error.message
        ))
    }
    
    func showDetail(profile: ProfileDisplay) {
        display?.showDetail(profile: profile)
    }
}

private extension Array where Element == ProfileDisplay {
    var mappedToViewModels: [ListScene.ProfilesViewModel.ProfileViewModel] {
        enumerated().map { index, profile in
            return ListScene.ProfilesViewModel.ProfileViewModel(
                name: "\(profile.profile.name.first) \(profile.profile.name.last)",
                email: profile.profile.email,
                color: profile.color,
                imagePublisher: profile.imageDownloader
            )
        }
    }
}

private extension APIError {
    var title: String {
        switch self {
        case .urlFormat, .server:
            return "Oopsie...".localized
        case .connectivity:
            return "Network error".localized
        }
    }
    var message: String {
        switch self {
        case .urlFormat, .server:
            return "An internal problem occured, try again later.".localized
        case .connectivity:
            return "There was an error connecting. Please check your internet".localized
        }
    }
}
