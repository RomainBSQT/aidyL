//
//  API.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation
import Combine
import UIKit.UIImage

final class API {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(
        type: T.Type,
        request: URLRequest
    ) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func downloadImage(url: URL) -> AnyPublisher<UIImage, Never> {
        return session.dataTaskPublisher(for: url)
            .map { imageData, _ in
                guard let image = UIImage(data: imageData) else { return UIImage() }
                return image
            }
            .replaceError(with: UIImage())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case urlFormat
    case connectivity
    case server
    
    init(error: Error) {
        switch error._code {
        case NSURLErrorTimedOut,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorNetworkConnectionLost:
            self = .connectivity
        default:
            self = .server
        }
    }
}
