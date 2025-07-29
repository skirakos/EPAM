import XCTest
// add @testable import for your main target if you use XCode project

enum TestErrors: Error {
    case notImplemented
}

class MockUserService: UserServiceProtocol {
    var fetchUserClosure: (Int) async throws -> User = { _ in
        XCTFail("unimplemented")
        throw TestErrors.notImplemented
    }
    func fetchUser(by id: Int) async throws -> User {
        try await fetchUserClosure(id)
    }

    var fetchSomeDataClosure: () async throws -> String = {
        XCTFail("unimplemented")
        throw TestErrors.notImplemented
    }
    func fetchSomeData() async throws -> String {
        try await fetchSomeDataClosure()
    }
}

class ViewModelAdvancedTests: XCTestCase {
    var viewModel: ViewModelAdvanced!
    var serviceMock: MockUserService!

    override func setUp() async throws {
        serviceMock = MockUserService()
        viewModel = ViewModelAdvanced(userService: serviceMock)
    }

    func testUserFetch_success() async {
        let userMock = User(id: 1, name: "John Smith")
        let someDataMock = "someData"

        let expUserService = expectation(description: "Service not called")
        serviceMock.fetchUserClosure = { id in
            defer { expUserService.fulfill() }
            // What we should do here?
            return userMock
        }

        let expSomeData = expectation(description: "Fetch some data not called")
        serviceMock.fetchSomeDataClosure = {
            defer { expSomeData.fulfill() }
            // What we should do here?
            return someDataMock
        }

        
        viewModel.fetchUserButtonTapped()
        XCTAssertEqual(viewModel.displayedText, "Loading...")
        
        /// How to check state of viewModel.displayedText when
        /// `fetchUserClosure` and then `fetchSomeDataClosure` are completed?

        await fulfillment(of:[expUserService, expSomeData])
    }
}
