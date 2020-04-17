//
//  RequestData.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

struct RequestData {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]
    let headers: Set<HTTPHeader>
    
    init(path: String,
         method: HTTPMethod,
         parameters: [String: Any] = [:],
         headers: Set<HTTPHeader> = []) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

enum HTTPHeader: Hashable {
    case apiKey
    
    var key: String {
        switch self {
        case .apiKey: return "x-api-key"
        }
    }
    
    var value: String {
        switch self {
        case .apiKey: return "4e4a7378-a497-4846-b043-50543ebb4a13"
        }
    }
    
    static var `default`: [HTTPHeader] {
        return [.apiKey]
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
