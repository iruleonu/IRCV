//
//  URLSession+Async.swift
//  IRCV
//
//  Created by Nuno Salvador on 26/04/2024.
//  Copyright © 2024 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    func fetchDataAsync(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let task = Task.detached {
            let (data, response) = try await self.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw DataProviderError.unknown
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw DataProviderError.requestError(httpStatusCode: httpResponse.statusCode, error: nil)
            }

            return (data, httpResponse)
        }
        return try await withTaskCancellationHandler {
                try await task.value
            } onCancel: {
                task.cancel()
            }
    }
}
