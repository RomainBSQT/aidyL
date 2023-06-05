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
}

struct ProfileConfiguration {
    let profile: Profile
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
        worker.fetchRandomUsers(amount: Constants.resultAmount, page: currentPage)
            .delay(for: 3, scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                switch completion {
                case .finished:
                    self?.currentPage += 1
                case .failure:
                    break
                }
            }, receiveValue: { [weak self] profiles in
                guard let self = self else { return }
                let profileConfigurations = profiles.mappedToProfileConfiguration(worker: worker)
                self.profiles.append(contentsOf: profileConfigurations)
                self.presenter.present(self.profiles)
            })
            .store(in: &subscriptions)
    }
    
    func freshLoadProfiles() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        isFetching = false
        currentPage = 1
        profiles = []
        loadProfiles()
    }
}

private extension Array where Element == Profile {
    func mappedToProfileConfiguration(worker: RandomUserBusinessLogic) -> [ProfileConfiguration] {
        map { profile in
            return ProfileConfiguration(
                profile: profile,
                imageDownloader: worker.downloadImage(url: profile.picture.medium)
            )
        }
    }
}
