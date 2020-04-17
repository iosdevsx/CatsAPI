//
//  RandomCatEndpoint.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

struct Paging {
    let limit: Int
    var page: Int
}

struct RandomCatEndpoint: Endpoint {
    private let paging: Paging
    
    init(paging: Paging) {
        self.paging = paging
    }
    
    func requestData() -> RequestData {
        return RequestData(path: "images/search", method: .get, parameters: ["limit": paging.limit,
                                                                             "page": paging.page])
    }
    
    typealias Response = [RandomCat]
}
