//
//  ListPresenter+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

final class ListPresenterMock: ListPresenterLogic {
    private(set) var startCounter = 0
    func start() {
        startCounter += 1
    }
    
    private(set) var presentProfilesCounter = 0
    private(set) var profilesParameter: [ProfileDisplay]?
    func present(_ profiles: [ProfileDisplay]) {
        presentProfilesCounter += 1
        profilesParameter = profiles
    }
    
    private(set) var errorCounter = 0
    private(set) var errorParameter: APIError?
    func error(_ error: APIError) {
        errorCounter += 1
        errorParameter = error
    }
    
    private(set) var showDetailCounter = 0
    private(set) var profileParameter: ProfileDisplay?
    func showDetail(profile: ProfileDisplay) {
        showDetailCounter += 1
        profileParameter = profile
    }
}

