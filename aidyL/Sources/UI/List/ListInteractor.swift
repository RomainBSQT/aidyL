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
}

final class ListInteractor: ListInteractorLogic {
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
        worker.fetchRandomUsers(amount: 10, page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure: break
                }
            }, receiveValue: { [weak self] profiles in
                guard let self = self else { return }
                let profileTuples: [
                    (profile: Profile, imagePublisher: AnyPublisher<UIImage, Never>)
                ] = profiles.map { profile in
                    return (
                        profile,
                        self.worker.downloadImage(url: profile.picture.medium)
                    )
                }
                self.presenter.present(profileTuples)
            })
            .store(in: &subscriptions)
    }
}
