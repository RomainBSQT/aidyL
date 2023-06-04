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
    func present(_ profiles: [(profile: Profile, imagePublisher: AnyPublisher<UIImage, Never>)])
}

final class ListPresenter: ListPresenterLogic {
    weak var display: ListDisplayLogic?
    
    private lazy var colors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemGreen,
        .systemMint,
        .systemBlue,
        .systemIndigo,
        .systemPurple,
        .systemPink,
        .systemBrown
    ]
    
    func start() {
        display?.initial(ListScene.InitialViewModel())
    }
    
    func present(_ profileTuples: [(profile: Profile, imagePublisher: AnyPublisher<UIImage, Never>)]) {
        let viewModels = profileTuples.enumerated().map { index, tuple in
            let colorIndex = index % colors.count
            return ListScene.ProfilesViewModel.ProfileViewModel(
                id: tuple.profile.id,
                firstName: tuple.profile.name.first,
                lastName: tuple.profile.name.last,
                color: colors[colorIndex],
                imagePublisher: tuple.imagePublisher
            )
        }
        display?.profiles(ListScene.ProfilesViewModel(profiles: viewModels))
    }
}
