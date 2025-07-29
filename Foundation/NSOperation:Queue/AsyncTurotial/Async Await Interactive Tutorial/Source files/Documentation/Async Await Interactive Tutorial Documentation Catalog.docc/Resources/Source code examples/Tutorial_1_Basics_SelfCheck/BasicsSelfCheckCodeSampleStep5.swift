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
    /*
     In order to make the code compile we need to call async function
     from withing the async context. In order to do it, we need to declare
     it using `Task`.
     */
    func viewDidAppear() {
        // here we have old way thread paradigm
        Task {
            // here we have new Swift Sturctured Concurrancy world
            serverStatus = try await api.fetchServerStatus()
            /*
             Please note, that a call of the updateUI function inside of the
             task context requires syncing, becuase method is annotaded with `@MainsActor`,
             and it means that we also need to wait till it finishes asyncrhonously
             */
            await updateUI(for: serverStatus)
        }
    }

    @MainActor
    func updateUI(for status: ServerStatus) {
        /*
         Required UI updates ..
         */
    }
}
