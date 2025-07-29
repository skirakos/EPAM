struct User {
    let id: Int
    let name: String
}

class ViewModel {
    func fetchUserButtonTapped() {
        // fetch user from some service (async)
        // update UI with received user + some formatting
    }
}

