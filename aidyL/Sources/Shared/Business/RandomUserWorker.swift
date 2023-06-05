//
//  RandomUserWorker.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Combine
import UIKit.UIImage

protocol RandomUserBusinessLogic {
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError>
    func fetchFreshRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError>
    func downloadImage(url: URL) -> AnyPublisher<UIImage, Never>
}

struct RandomUserWorker: RandomUserBusinessLogic {
    private let datasource: RandomUserDatasource
    
    init(datasource: RandomUserDatasource) {
        self.datasource = datasource
    }
    
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        return datasource.fetchRandomUsers(amount: amount, page: page)
    }
    
    func fetchFreshRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        return datasource.fetchFreshRandomUsers(amount: amount, page: page)
    }

    func downloadImage(url: URL) -> AnyPublisher<UIImage, Never> {
        return datasource.downloadProfileImage(url: url)
    }
}
