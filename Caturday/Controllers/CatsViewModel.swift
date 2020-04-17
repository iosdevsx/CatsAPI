//
//  CatsViewModel.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

struct RandomCat: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

protocol ICatsViewModel {
    var catsCount: Int { get }
    var reloadAction: (() -> ())? { get set }
    
    func cat(at index: Int) -> RandomCat
    func fetchRandomCat()
}

class CatsViewModel {
    private var cats: [RandomCat] = []
    private let catsService: ICatsService
    private var paging = Paging(limit: 50, page: 0)
    private var isLoading = false
    
    var reloadAction: (() -> ())?
    
    var catsCount: Int {
        cats.count
    }
    
    func cat(at index: Int) -> RandomCat {
        cats[index]
    }
    
    init(catsService: ICatsService) {
        self.catsService = catsService
    }
}

extension CatsViewModel: ICatsViewModel {
    
    func fetchRandomCat() {
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        catsService.getRandomCats(paging: paging) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case let .success(randomCats):
                self.paging.page += 1
                self.cats.append(contentsOf: randomCats)
                self.reloadAction?()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
