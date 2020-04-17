//
//  APIClient.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Codable
    func requestData() -> RequestData
}

protocol IAPIClient {
    func send<T: Endpoint>(endpoint: T, responseHandler: @escaping (Result<T.Response, Error>) -> Void)
}

struct APIClient {
    private let requestFactory: IRequestFactory
    private let session: URLSession
    
    init(requestFactory: IRequestFactory,
         session: URLSession) {
        self.requestFactory = requestFactory
        self.session = session
    }
}

extension APIClient: IAPIClient {
    func send<T>(endpoint: T, responseHandler: @escaping (Result<T.Response, Error>) -> Void) where T : Endpoint {
        let urlRequest: URLRequest
        
        let responseHandler: (Result<T.Response, Error>) -> Void = { result in
            DispatchQueue.main.async {
                responseHandler(result)
            }
        }
        
        do {
            urlRequest = try requestFactory.makeRequest(data: endpoint.requestData())
        } catch {
            if let error = error as? NetworkError {
                responseHandler(.failure(error))
            } else {
                responseHandler(.failure(NetworkError.unknown))
            }
            
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                responseHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                responseHandler(.failure(NetworkError.noOutput))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.Response.self, from: data)
                responseHandler(.success(decoded))
            } catch {
                responseHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
