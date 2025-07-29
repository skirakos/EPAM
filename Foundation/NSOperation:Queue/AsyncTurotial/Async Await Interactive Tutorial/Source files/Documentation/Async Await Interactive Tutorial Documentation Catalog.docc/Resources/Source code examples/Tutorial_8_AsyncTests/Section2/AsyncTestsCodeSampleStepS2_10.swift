class ViewModelCancellation {
    var userService: UserServiceProtocol
    var displayedText: String = ""

    private var fetchSomeDataTask: Task<Void, Error>?

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func fetchUserButtonTapped() {
        fetchSomeDataTask?.cancel()

        self.fetchSomeDataTask = Task {
            displayedText = (try? await self.userService.fetchSomeData()) ?? ""
        }
    }
}


