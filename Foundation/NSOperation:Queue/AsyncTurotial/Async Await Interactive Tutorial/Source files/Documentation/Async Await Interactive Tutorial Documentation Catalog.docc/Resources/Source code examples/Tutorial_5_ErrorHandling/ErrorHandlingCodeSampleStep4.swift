import Foundation

enum ProcessingError: Error {
    case Length
    case BadUrl
}

func doSomething(with str: String,
                 completionHandler: 
                 @escaping (Result<String, ProcessingError>) -> Void ) async {
    if str.count < 2 {
        completionHandler(.failure(.Length))
    }
    guard let url = URL(string: str) else {
        completionHandler(.failure(.BadUrl))
        return
    }
    return completionHandler(.success(processMe.uppercased()))
}

await doSomething(with: "process me") { result in
    switch result {
    case .success(let result):
        print(result)
    case .failure(let error):
        switch error {
        case .Length:
            print("Length Error")
        case .BadUrl:
            print("Bad Url")
        }
    }
}

