enum ProcessingError: Error {
    case Length
    case BadUrl
}

func doSomething(with str: String) async throws(ProcessingError) -> String {
    if str.count < 2 {
        throw ProcessingError.Length
    }
    guard let url = URL(string: str) else {
        throw ProcessingError.BadUrl
    }
    return str.uppercased()
}

do throws(ProcessingError) {
    let newString = try await doSomething(with: "process me")
    print("I'm completed with \(newString)")
} catch ProcessingError.Length {
    print("Length Error")
} catch ProcessingError.BadUrl {
    print("Bad Url")
}
