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
    func downloadProfileImage(url: URL) -> AnyPublisher<UIImage, Never>
}

extension API: RandomUserDatasource {
    enum Url {
        static let base = "https://randomuser.me/api/"
    }

    func fetchRandomUsers(amount: Int, page: Int) -> AnyPublisher<[Profile], APIError> {
        guard var components = URLComponents(string: Url.base) else {
            return Fail(error: APIError.urlFormat).eraseToAnyPublisher()
        }
        components.queryItems = [
            URLQueryItem(name: "results", value: String(amount))
        ]
        guard let url = components.url else { fatalError() }
        let request = URLRequest(url: url)
        return get(type: RandomUserResponse.self, request: request)
            .map(\.results)
            .mapError(APIError.init)
            .eraseToAnyPublisher()
    }
    
    func downloadProfileImage(url: URL) -> AnyPublisher<UIImage, Never> {
        return downloadImage(url: url)
    }
}

struct RandomUserResponse: Decodable {
    let results: [Profile]
}
