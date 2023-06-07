//
//  DetailDisplay+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

final class DetailDisplayMock: DetailDisplayLogic {
    private(set) var initialCounter: Int = 0
    private(set) var initialViewModel: DetailScene.InitialViewModel?
    func initial(_ viewModel: DetailScene.InitialViewModel) {
        initialCounter += 1
        initialViewModel = viewModel
    }
    
    private(set) var mapSnapshotCounter: Int = 0
    private(set) var mapSnapshortViewModel: DetailScene.MapSnapshotViewModel?
    func mapSnapshot(_ viewModel: DetailScene.MapSnapshotViewModel) {
        mapSnapshotCounter += 1
        mapSnapshortViewModel = viewModel
    }
}
