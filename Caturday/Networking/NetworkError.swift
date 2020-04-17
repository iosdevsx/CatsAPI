//
//  NetworkError.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case incorrectURL
    case unknown
    case noOutput
    
    var localizedDescription: String {
        switch self {
        case .incorrectURL: return "Неверный путь"
        case .unknown: return "Неизвестная ошибка"
        case .noOutput: return "Нет данных"
        }
    }
}
