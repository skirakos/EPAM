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
