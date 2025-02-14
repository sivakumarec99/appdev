//
//  UserRepository.swift
//  JsonService
//
//  Created by JIDTP1408 on 12/02/25.
//

import Foundation

protocol UserRepository {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

final class UserRepositoryImpl: UserRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        apiClient.request(.getUsers, completion: completion)
    }
}

