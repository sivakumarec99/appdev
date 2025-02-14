//
//  GetUserUseCase.swift
//  JsonService
//
//  Created by JIDTP1408 on 12/02/25.
//

import Foundation

protocol GetUsersUseCase {
    func execute(completion: @escaping (Result<[User], Error>) -> Void)
}

final class GetUsersUseCaseImpl: GetUsersUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[User], Error>) -> Void) {
        repository.fetchUsers(completion: completion)
    }
}
