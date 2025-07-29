struct User {
    let id: Int
    let name: String
}

protocol UserServiceProtocol {
    func fetchUser(by id: Int) async throws -> User
    func fetchSomeData() async throws -> String
}

class ViewModelAdvanced {
    var userService: UserServiceProtocol
    var displayedText: String = ""

    private var user: User?
    private var someOtherData: String?

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func fetchUserButtonTapped() {
        self.displayedText = "Loading..."
        
        Task {
            self.user = try? await self.userService.fetchUser(by: 1)
        }

        Task {
            self.someOtherData = try? await self.userService.fetchSomeData()
        }
    }
}
