struct User {
    let id: Int
    let name: String
}

enum APIError: Error {
    case userNotFound
}

protocol UserServiceProtocol {
    func fetchUser(by id: Int) async throws -> User
}

class ViewModel {
    let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func fetchUserButtonTapped() {
        Task { @MainActor [weak self] in
            do {
                guard let user = try await self?.userService.fetchUser(by: 1) else { return }
                // update UI with received user + some formatting
            } catch {
                // show error here
            }
        }
    }
}
