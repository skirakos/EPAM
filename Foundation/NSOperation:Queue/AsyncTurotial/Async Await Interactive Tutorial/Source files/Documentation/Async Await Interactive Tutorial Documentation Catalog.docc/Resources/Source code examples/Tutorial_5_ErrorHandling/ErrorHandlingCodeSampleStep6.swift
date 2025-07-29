import Foundation

func doSomething(with str: String) async -> Task<String, ProcessingError> {
    if str.count < 2 {
        return .failure(.Length)
    }
    guard let url = URL(string: str) else {
        return .failure(.BadUrl)
    }
    return .success(str.uppercased())
}

switch try await doSomething("process me") {
    case .success(let newString):
        print ("I'm completed with \(newString)")
    case .failure(let error):
     switch error {
     case .Length:
        print("Length Error")
     case .BadUrl:
        print("Bad Url")
     }
}
