//
//  CatsService.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

protocol ICatsService {
    func getRandomCats(paging: Paging, completion: @escaping (Result<[RandomCat], Error>) -> Void)
}

struct CatsService {
    private let apiClient: IAPIClient

    init(apiClient: IAPIClient) {
        self.apiClient = apiClient
    }
}

extension CatsService: ICatsService {
    func getRandomCats(paging: Paging, completion: @escaping (Result<[RandomCat], Error>) -> Void) {
        apiClient.send(endpoint: RandomCatEndpoint(paging: paging), responseHandler: completion)
    }
}

