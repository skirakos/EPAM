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

    @MainActor
    func testUserFetch_success() async {
        let userMock = User(id: 1, name: "John Smith")
        let someDataMock = "someData"

        let (userStream, userContinuation) = AsyncStream.makeStream(of: User.self)
        let (someDataStream, someDataConntinuation) = AsyncStream.makeStream(of: String.self)

        let expUserService = expectation(description: "Service not called")
        serviceMock.fetchUserClosure = { id in
            defer { expUserService.fulfill() }
            var iterator = userStream.makeAsyncIterator()
            guard let user = await iterator.next()  else {
                XCTFail("unexpected nil")
                throw TestErrors.notImplemented
            }

            return user
        }

        let expSomeData = expectation(description: "Fetch some data not called")
        serviceMock.fetchSomeDataClosure = {
            defer { expSomeData.fulfill() }
            var iterator = someDataStream.makeAsyncIterator()
            guard let someData = await iterator.next() else {
                XCTFail("unexpected nil")
                throw TestErrors.notImplemented
            }

            return someData
        }

        viewModel.fetchUserButtonTapped()
        XCTAssertEqual(viewModel.displayedText, "Loading...")

        // emiting first API
        userContinuation.yield(userMock)
        await fulfillment(of: [expUserService], timeout: 1)
        await Task.yield()
        XCTAssertEqual(viewModel.displayedText, "1 of 2 is completed")

        // emiting second API
        someDataConntinuation.yield(someDataMock)
        await fulfillment(of: [expSomeData], timeout: 1)
        await Task.yield()
        XCTAssertEqual(viewModel.displayedText, "2 of 2 is completed")
    }
}
