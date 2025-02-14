//
//  APIService.swift
//  JsonService
//
//  Created by JIDTP1408 on 12/02/25.
//

import Foundation
enum APIService {
    case getUsers

    var url: URL? {
        switch self {
        case .getUsers:
            return URL(string: "https://jsonplaceholder.typicode.com/users")
        }
    }
}
