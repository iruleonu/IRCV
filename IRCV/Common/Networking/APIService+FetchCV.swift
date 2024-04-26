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
    func fetchUserProfileAsync() async throws -> User
    func fetchUserProfileAsyncResult() async -> Result<User, APIServiceError>
}

extension APIServiceImpl: APIFetchCVProtocol {
    func fetchUserProfile() -> AnyPublisher<User, APIServiceError> {
        let properties = Resource.nscv.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) -> Future<User, APIServiceError> = { tuple in
            Future { promise in
                do {
                    let result = try JSONDecoder().decode(User.self, from: tuple.0)
                    promise(.success(result))
                } catch {
                    promise(.failure(APIServiceError.parsing(error: error)))
                }
            }
        }
        return session.fetchData(urlRequest)
            .mapError { APIServiceError.network(error: $0) }
            .flatMap(parseData)
            .eraseToAnyPublisher()
    }

    func fetchUserProfileAsync() async throws -> User {
        let properties = Resource.nscv.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) throws -> User = { tuple in
            do {
                let result = try JSONDecoder().decode(User.self, from: tuple.0)
                return result
            } catch {
                throw APIServiceError.parsing(error: error)
            }
        }

        let dataResponse = try await session.fetchDataAsync(urlRequest)
        let parsedUser = try parseData(dataResponse)
        return parsedUser
    }

    func fetchUserProfileAsyncResult() async -> Result<User, APIServiceError> {
        let properties = Resource.nscv.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) throws -> User = { tuple in
            do {
                let result = try JSONDecoder().decode(User.self, from: tuple.0)
                return result
            } catch {
                throw APIServiceError.parsing(error: error)
            }
        }
        do {
            let fetchDataResponse = try await session.fetchDataAsync(urlRequest)
            let parsedUser = try parseData(fetchDataResponse)
            return Result.success(parsedUser)
        } catch let e {
            return Result.failure(APIServiceError.network(error: e))
        }
    }
}
