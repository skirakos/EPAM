import Foundation

enum ProcessingError: Error {
    case Length
    case BadUrl
}

func doSomething(with str: String) async -> Result<String, ProcessingError> {
    if str.count < 2 {
        return .failure(.Length)
    }
    guard let url = URL(string: str) else {
        return .failure(.BadUrl)
    }
    return .success(str.uppercased())
}

let newString =  await doSomething(with: "process me")
switch newString  {
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
