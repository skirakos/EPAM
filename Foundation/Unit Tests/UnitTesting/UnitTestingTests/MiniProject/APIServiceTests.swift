//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let expectation = self.expectation(description: "Completion should return .invalidUrl")
        let sut = APIService(urlSession: mockURLSession)

        sut.fetchUsers(urlString: "ht tp://invalid url.com") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidUrl)
            default:
                XCTFail("Expected failure with .invalidUrl but got \(result)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
        
        
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        
        
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let expectedUsers = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@gmail.com"),
            User(id: 2, name: "Jane Doe", username: "johndoe", email: "johndoe@gmail.com")
        ]
        
        let expectation = self.expectation(description: "Completion should return .success")
        sut.fetchUsers(urlString: "www.example.com", completion: { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users, expectedUsers)
                expectation.fulfill()
            default:
                XCTFail()
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 0.1)
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "email": "johndoe@gmail.com" },
            { "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        
        let expectation = self.expectation(description: "Completion handler invoked")
        let sut = makeSut()
        mockURLSession.mockData = response

        sut.fetchUsers(urlString: "https://example.com") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .parsingError)
            default:
                XCTFail("Expected parsingError, got \(result)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }


    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        let expectation = self.expectation(description: "Completion handler invoked")
        mockURLSession.mockData = nil
        let sut = makeSut()
        
        sut.fetchUsers(urlString: "https://example.com", completion: { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            default:
                XCTFail("Expected .unexpected, got \(result)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
       let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "ht tp://invalid url.com")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidUrl)
        default:
            XCTFail("Expected .invalidUrl, got \(result)")
        }
    }

    // TODO: Implement test
    // add other tests for fetchUsersAsync
    func test_apiService_fetchUsersAsync_whenSuccess() async {
        let response = """
        [
            { "id": 1, "name": "John", "username": "john123", "email": "john@example.com" },
            { "id": 2, "name": "Jane", "username": "jane123", "email": "jane@example.com" }
        ]
        """.data(using: .utf8)

        mockURLSession.mockData = response
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "www.example.com")
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 2)
            XCTAssertEqual(users[0].name, "John")
            XCTAssertEqual(users[1].name, "Jane")
        default:
            XCTFail("Expected .success but got \(result)")
        }
    }
    
    // TODO: Implement test
    func test_apiService_fetchUsersAsync_whenFailedToDecode() async {
        let response = "Invalid JSON".data(using: .utf8)!
        mockURLSession.mockData = response
        let sut = makeSut()

        let result = await sut.fetchUsersAsync(urlString: "www.example.com")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .parsingError)
        default:
            XCTFail("Expected .failure but got \(result)")
        }
    }

    
    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
