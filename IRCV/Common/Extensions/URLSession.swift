//
//  URLSession.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 21/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    func fetchData(_ request: URLRequest) -> AnyPublisher<(Data, URLResponse), DataProviderError> {
        AnyPublisher { subscriber in
            let task = self.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, let response = response else {
                        if let e = error {
                            subscriber.receive(completion: .failure(DataProviderError.requestError(error: e)))
                        }
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        subscriber.receive(completion: .failure(.unknown))
                        return
                    }
                    
                    guard 200..<300 ~= httpResponse.statusCode else {
                        subscriber.receive(completion: .failure(DataProviderError.requestError(httpStatusCode: httpResponse.statusCode, error: error)))
                        return
                    }
                    
                    _ = subscriber.receive((data, httpResponse))
                    subscriber.receive(completion: .finished)
                }
            }
            
            subscriber.receive(subscription: AnySubscription(task.cancel))
            task.resume()
        }
    }
}
