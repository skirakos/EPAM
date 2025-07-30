//
//  MockURLSession.swift
//  UnitTesting
//

import Foundation

final class MockURLSession: URLSession, @unchecked Sendable {
    var mockData: Data?
    var mockError: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = mockData
        let error = mockError
        
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}

final class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
