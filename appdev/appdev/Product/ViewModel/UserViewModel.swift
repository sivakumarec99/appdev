//
//  UserViewModel.swift
//  JsonService
//
//  Created by JIDTP1408 on 12/02/25.
//

import Foundation

final class UserViewModel {
    private let getUsersUseCase: GetUsersUseCase
    var users: [User] = []
    var onUsersFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }

    func fetchUsers() {
        getUsersUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.onUsersFetched?()
                case .failure:
                    self?.onError?("Failed to fetch users.")
                }
            }
        }
    }
}
