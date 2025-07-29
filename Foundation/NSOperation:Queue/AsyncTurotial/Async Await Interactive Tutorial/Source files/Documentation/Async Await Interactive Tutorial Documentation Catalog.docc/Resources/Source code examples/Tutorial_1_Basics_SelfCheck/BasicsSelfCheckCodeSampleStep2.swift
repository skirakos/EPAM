import Foundation

enum ServerStatus {
    case up(Data)
    case down(Data)
}

class API {
    /*
     Let's assume we are implementing a transition to the new Async/Await API
     without the need of legacy code support.

     Basic frameworks have already been bundled with Async/Await support.
     */
    func fetchServerStatus() async throws -> ServerStatus {
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "http://amazingserver.com/status")!
        )
        return .up(data)
    }
}

class ViewController {
    let api = API()
    var serverStatus: ServerStatus

    init(serverStatus: ServerStatus) {
        self.serverStatus = serverStatus
    }

    func viewDidAppear() {
        api.fetchServerStatus { status in
            serverStatus = status
        }
    }
}
