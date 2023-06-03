//
//  RandomUserWorker.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Combine

protocol RandomUserBusinessLogic {
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError>
}

struct RandomUserWorker: RandomUserBusinessLogic {
    private let datasource: RandomUserDatasource
    
    init(datasource: RandomUserDatasource) {
        self.datasource = datasource
    }
    
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        return datasource.fetchRandomUsers(amount: amount, page: page)
    }
}
