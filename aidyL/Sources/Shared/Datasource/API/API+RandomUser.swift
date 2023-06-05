//
//  API+RandomUser.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation
import Combine
import UIKit

protocol RandomUserDatasource {
    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError>
    func fetchFreshRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError>
    func downloadProfileImage(url: URL) -> AnyPublisher<UIImage, Never>
}

extension API: RandomUserDatasource {
    enum Url {
        static let base = "https://randomuser.me/api/"
    }

    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        fetchUsers(amount: amount, page: page, cachePolicy: .returnCacheDataElseLoad)
    }
    
    func fetchFreshRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        return fetchUsers(amount: amount, page: page, cachePolicy: .reloadIgnoringLocalCacheData)
    }
    
    func downloadProfileImage(url: URL) -> AnyPublisher<UIImage, Never> {
        return downloadImage(url: url)
    }
}

private extension API {
    func fetchUsers(amount: Int, page: Int, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<[Profile], APIError> {
        guard var components = URLComponents(string: Url.base) else {
            return Fail(error: APIError.urlFormat).eraseToAnyPublisher()
        }
        components.queryItems = [
            URLQueryItem(name: "results", value: String(amount)),
            URLQueryItem(name: "page", value: String(page))
        ]
        guard let url = components.url else { fatalError() }
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        return get(type: RandomUserResponse.self, request: request)
            .map(\.results)
            .mapError(APIError.init)
            .eraseToAnyPublisher()
    }
}

struct RandomUserResponse: Decodable {
    let results: [Profile]
}
