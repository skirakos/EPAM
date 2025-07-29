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

protocol UserDisplayable {
    func display(user: String)
    func display(error: String)
}

class ViewModel {
    let userService: UserServiceProtocol
    let view: UserDisplayable

    init(userService: UserServiceProtocol,
         view: UserDisplayable) {
        self.userService = userService
        self.view = view
    }

    func fetchUserButtonTapped() {
        Task { @MainActor [weak self] in
            do {
                guard let user = try await self?.userService.fetchUser(by: 1) else { return }
                self?.view.display(user: "Current user: " + user.name) // success
            } catch {
                self?.view.display(error: "Something went wrong") // failure
            }
        }
    }
}
