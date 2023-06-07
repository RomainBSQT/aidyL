//
//  DetailPresenter+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import UIKit

final class DetailPresenterMock: DetailPresenterLogic {
    private(set) var startCounter = 0
    private(set) var profileParameter: ProfileDisplay?
    func start(_ profile: ProfileDisplay) {
        startCounter += 1
        profileParameter = profile
    }
    
    private(set) var mapSnapshotCounter = 0
    private(set) var imageParameter: UIImage?
    var mapSnapshotCompletion: (() -> Void)?
    func mapSnapshot(_ image: UIImage) {
        mapSnapshotCounter += 1
        imageParameter = image
        mapSnapshotCompletion?()
    }
}

