//
//  Factories.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

class Factories {
    static let shared = Factories()
    
    static var resolveApiClient: IAPIClient = {
        let urlSession = URLSession(configuration: .default)
        urlSession.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let apiClient: IAPIClient = APIClient(requestFactory: resolveRequestFactory, session: urlSession)
        return apiClient
    }()
    
    static var resolveRequestFactory: IRequestFactory = {
        let baseURL = URL(string: "https://api.thecatapi.com/v1/")!
        let requestFactory: IRequestFactory = RequestFactory(baseURL: baseURL)
        return requestFactory
    }()
    
    static var catsService: ICatsService = {
        return CatsService(apiClient: resolveApiClient)
    }()
    
    static var catsController: UIViewController = {
        let vm = CatsViewModel(catsService: catsService)
        let vc = CatsController(viewModel: vm)
        return vc
    }()
}
