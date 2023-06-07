//
//  ListDisplay+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

final class ListDisplayMock: ListDisplayLogic {
    private(set) var initialCounter: Int = 0
    private(set) var initialViewModel: ListScene.InitialViewModel?
    func initial(_ viewModel: ListScene.InitialViewModel) {
        initialCounter += 1
        initialViewModel = viewModel
    }
    
    private(set) var profilesCounter: Int = 0
    private(set) var profilesViewModel: ListScene.ProfilesViewModel?
    func profiles(_ viewModel: ListScene.ProfilesViewModel) {
        profilesCounter += 1
        profilesViewModel = viewModel
    }
    
    private(set) var errorCounter: Int = 0
    private(set) var errorViewModel: ListScene.ErrorViewModel?
    func error(_ viewModel: ListScene.ErrorViewModel) {
        errorCounter += 1
        errorViewModel = viewModel
    }
    
    private(set) var detailCounter: Int = 0
    private(set) var profileParameter: ProfileDisplay?
    func showDetail(profile: ProfileDisplay) {
        detailCounter += 1
        profileParameter = profile
    }
}
