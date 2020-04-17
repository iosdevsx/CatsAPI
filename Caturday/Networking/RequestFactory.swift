//
//  RequestFactory.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

protocol IRequestFactory {
    func makeRequest(data: RequestData) throws -> URLRequest
}

struct RequestFactory {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

extension RequestFactory: IRequestFactory {
    func makeRequest(data: RequestData) throws -> URLRequest {
        var urlRequest = try URLRequest(url: buildUrl(with: data))
        urlRequest.httpMethod = data.method.rawValue
        urlRequest.timeoutInterval = 30
        
        
        for header in data.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        for header in HTTPHeader.default {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return urlRequest
    }
    
    private func buildUrl(with request: RequestData) throws -> URL {
        var urlString = request.path

        if !request.parameters.isEmpty {
            let urlParameters = request.parameters.compactMap { item -> String? in
                guard
                    let key = item.key
                        .addingPercentEncoding(withAllowedCharacters: .alphanumerics),
                    let value = String(describing: item.value)
                        .addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                    else {
                        return nil
                }
                return key + "=" + value
            }
            urlString += "?" + urlParameters.joined(separator: "&")
        }

        guard let url = URL(string: urlString, relativeTo: baseURL) else {
            throw NetworkError.incorrectURL
        }

        return url
    }
}
