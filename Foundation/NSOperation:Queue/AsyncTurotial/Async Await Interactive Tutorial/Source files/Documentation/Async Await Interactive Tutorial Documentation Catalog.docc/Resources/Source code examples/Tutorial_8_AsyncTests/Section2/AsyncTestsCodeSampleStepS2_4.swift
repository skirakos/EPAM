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
        /// We should check that:
        /// Right after calling `fetchUserButtonTapped` the variable `displayedText` becomes "Loading"
        /// Then when first API call is completed it becomes "1 of 2 is completed"
        /// When second one API call is completed it becomes "2 of 2 is completed"
    }
}
