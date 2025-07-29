import Foundation

enum ProcessingError: Error {
    case Length
    case BadUrl
}

func doSomething(with str: String) async throws -> String {
    if str.count < 2 {
        throw ProcessingError.Length
    }
    guard let url = URL(string: str) else {
        throw ProcessingError.BadUrl
    }
    return str.uppercased()
}

do {
    let newString = try await doSomething(with: "process me")
    print("I'm completed with \(newString)")
} catch ProcessingError.Length {
    print("Length Error")
} catch ProcessingError.BadUrl {
    print("Bad Url")
} catch let error {
    print(error.localizedDescription)
}


