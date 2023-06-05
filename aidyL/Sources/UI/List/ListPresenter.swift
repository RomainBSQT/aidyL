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
    func present(_ profiles: [ProfileConfiguration])
}

final class ListPresenter: ListPresenterLogic {
    weak var display: ListDisplayLogic?
    
    func start() {
        display?.initial(ListScene.InitialViewModel())
    }
    
    func present(_ profiles: [ProfileConfiguration]) {
        display?.profiles(ListScene.ProfilesViewModel(profiles: profiles.mappedToViewModels))
    }
}

private extension Array where Element == ProfileConfiguration {
    var mappedToViewModels: [ListScene.ProfilesViewModel.ProfileViewModel] {
        enumerated().map { index, profile in
            return ListScene.ProfilesViewModel.ProfileViewModel(
                name: "\(profile.profile.name.first) \(profile.profile.name.last)",
                email: profile.profile.email,
                imagePublisher: profile.imageDownloader
            )
        }
    }
}
