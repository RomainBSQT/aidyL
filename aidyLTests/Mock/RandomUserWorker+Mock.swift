//
//  RandomUserWorker+Mock.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import Combine
import UIKit

final class RandomUserWorkerMock: RandomUserBusinessLogic {

    var fetchRandomUsersMockResult: AnyPublisher<[Profile], APIError>?
    private(set) var fetchRandomUsersCounter = 0
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        self.fetchRandomUsersCounter += 1
        if let mock = fetchRandomUsersMockResult {
            return mock
        }
        return Just([.mock()])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    var fetchFreshRandomUsersMockResult: AnyPublisher<[Profile], APIError>?
    private(set) var fetchFreshRandomUsersCounter = 0
    func fetchFreshRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        self.fetchFreshRandomUsersCounter += 1
        if let mock = fetchFreshRandomUsersMockResult {
            return mock
        }
        return Just([.mock()])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    var downloadImageMockResult: AnyPublisher<UIImage, Never>?
    private(set) var downloadImageCounter = 0
    func downloadImage(url: URL) -> AnyPublisher<UIImage, Never> {
        self.downloadImageCounter += 1
        if let mock = downloadImageMockResult {
            return mock
        }
        return Just(UIImage()).eraseToAnyPublisher()
    }
}
