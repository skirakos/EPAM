class ViewModelAdvanced {
    var userService: UserServiceProtocol
    var displayedText: String = ""

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func fetchUserButtonTapped() {
        self.displayedText = "Loading..."
        /// 1. Start two API requests
        /// 2. When one of them is completed, set "1 of 2 is completed" to `displayedText`
        /// 3. When another one is completed, display "2 of 2 is complted" to `displayedText`
    }
}
