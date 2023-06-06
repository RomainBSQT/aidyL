//
//  ListInteractor.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation
import Combine
import UIKit

protocol ListInteractorLogic {
    func start()
    func loadProfiles()
    func freshLoadProfiles()
    func selectProfile(_ index: Int)
}

struct ProfileConfiguration {
    let profile: Profile
    let color: UIColor
    let imageDownloader: AnyPublisher<UIImage, Never>
}

final class ListInteractor: ListInteractorLogic {
    private enum Constants {
        static let resultAmount = 10
    }
    
    private var currentPage = 1
    private var isFetching = false
    private var profiles: [ProfileConfiguration] = []
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Injected
    private let presenter: ListPresenterLogic
    private let worker: RandomUserBusinessLogic
    
    init(presenter: ListPresenterLogic, worker: RandomUserBusinessLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - ListInteractorLogic conformance
    func start() {
        presenter.start()
    }
    
    func loadProfiles() {
        guard !isFetching else { return }
        isFetching = true
        let publisher = worker.fetchRandomUsers(
            amount: Constants.resultAmount,
            page: currentPage
        )
        handleFetching(publisher: publisher)
    }
    
    func freshLoadProfiles() {
        cleanup()
        let publisher = worker.fetchFreshRandomUsers(
            amount: Constants.resultAmount,
            page: currentPage
        )
        handleFetching(publisher: publisher)
    }
    
    func selectProfile(_ index: Int) {
        guard index < profiles.count else { return }
        presenter.showDetail(profile: profiles[index])
    }
}

private extension ListInteractor {
    func cleanup() {
        subscriptions.cleanup()
        isFetching = false
        currentPage = 1
        profiles = []
    }
    
    func handleFetching(publisher: AnyPublisher<[Profile], APIError>) {
        publisher
        //            .delay(for: 3, scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                switch completion {
                case .finished:
                    self?.currentPage += 1
                case .failure:
                    print("")
                    break
                }
            }, receiveValue: { [weak self] profiles in
                guard let self = self else { return }
                let profileConfigurations = profiles.mappedToProfileConfiguration(
                    indexOffset: self.profiles.count,
                    worker: worker
                )
                self.profiles.append(contentsOf: profileConfigurations)
                self.presenter.present(self.profiles)
            })
            .store(in: &subscriptions)
    }
}

private extension Array where Element == Profile {
    func mappedToProfileConfiguration(
        indexOffset: Int,
        worker: RandomUserBusinessLogic
    ) -> [ProfileConfiguration] {
        enumerated().map { index, profile in
            return ProfileConfiguration(
                profile: profile,
                color: UIColor.systemColor(indexOffset + index),
                imageDownloader: worker.downloadImage(url: profile.picture.large)
            )
        }
    }
}
