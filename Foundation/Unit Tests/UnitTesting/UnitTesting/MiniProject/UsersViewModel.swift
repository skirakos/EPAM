//
//  UsersViewModel.swift
//  UnitTesting
//

import Foundation

final class UsersViewModel: UsersViewModelProtocol {
    private let apiService: APIServiceProtocol

    private(set) var users: [User] = []
    private(set) var errorMessage: String?
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchUsers(completion: @escaping () -> Void) {
        apiService.fetchUsers(
            urlString: "https://jsonplaceholder.typicode.com/users"
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleFetchUsersResult(result)
                completion()
            }
        }
    }

    func clearUsers() {
        users = []
    }

    // MARK: Private
    private func handleFetchUsersResult(_ result: Result<[User], APIError>) {
        switch result {
        case let .success(users):
            self.users = users
        case let .failure(error):
            handleError(error)
        }
    }

    private func handleError(_ error: APIError) {
        switch error {
        case .invalidUrl, .unexpected:
            errorMessage = "Unexpected error"
        case .parsingError:
            errorMessage = "Error parsing JSON"
        }
    }
}
