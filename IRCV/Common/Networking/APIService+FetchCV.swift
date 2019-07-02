//
//  APIService+FetchCV.swift
//  IRCV
//
//  Created by Nuno Salvador on 13/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

protocol APIFetchCVProtocol {
    func fetchUserProfile() -> AnyPublisher<User, APIServiceError>
}

extension APIServiceImpl: APIFetchCVProtocol {
    func fetchUserProfile() -> AnyPublisher<User, APIServiceError> {
        let properties = Resource.nscv.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) -> AnyPublisher<User, APIServiceError> = { tuple in
            return AnyPublisher { subscriber in
                do {
                    let result = try JSONDecoder().decode(User.self, from: tuple.0)
                    _ = subscriber.receive(result)
                } catch {
                    subscriber.receive(completion: .failure(APIServiceError.parsing(error: error)))
                }
            }
        }
        
        return session.fetchData(urlRequest)
            .mapError { APIServiceError.network(error: $0) }
            .flatMap(parseData)
            .eraseToAnyPublisher()
    }
}
