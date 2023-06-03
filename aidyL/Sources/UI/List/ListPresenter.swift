//
//  ListPresenter.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

protocol ListPresenterLogic {
    func start()
    func present(_ profiles: [Profile])
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
    
    func present(_ profiles: [Profile]) {
        let viewModels = profiles.enumerated().map { index, profile in
            let colorIndex = index % colors.count
            return ListScene.ProfilesViewModel.ProfileViewModel(
                firstName: profile.name.first,
                lastName: profile.name.last,
                color: colors[colorIndex]
            )
        }
        display?.profiles(ListScene.ProfilesViewModel(profiles: viewModels))
    }
}
