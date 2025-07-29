import Foundation

enum ServerStatus {
    case up (Data)
    case down (Data)
}

class API {
    func fetchServerStatus(completion: @escaping (ServerStatus) -> Void) {
        URLSession.shared.dataTask(
            with: URL(string: "http://amazingserver.com/status")!
        ) { data, response, error in
            /*
             Decoding, error handling, etc

             Let's assume the status is .up
             */
            let serverStatus = ServerStatus.up(data)
            completion(serverStatus)
        }
        .resume()
    }
}

class ViewController {
    let api = API()
    var serverStatus: ServerStatus

    func viewDidAppear() {
        api.fetchServerStatus { status in
            self.serverStatus = status
        }
    }
}
