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
}

class MockUserDisplayable: UserDisplayable {
    var displayUserClosure: (String) -> Void = { _ in XCTFail("unimplemented") }
    func display(user: String) {
        displayUserClosure(user)
    }

    var displayErrorClosure: (String) -> Void = { _ in XCTFail("unimplemented") }
    func display(error: String) {
        displayErrorClosure(error)
    }
}

class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!
    var serviceMock: MockUserService!
    var viewMock: MockUserDisplayable!

    override func setUp() async throws {
        serviceMock = MockUserService()
        viewMock = MockUserDisplayable()
        viewModel = ViewModel(diplayable: viewMock, userService: serviceMock)
    }

    func testUserFetch_success() {
        let userMock = User(id: 1, name: "John Smith")

        let expService = expectation(description: "Service not called")
        serviceMock.fetchUserClosure = { id in
            defer { expService.fulfill() }
            XCTAssertEqual(id, 1)
            return userMock
        }

        let expView = expectation(description: "View not called")
        viewMock.displayUserClosure = { userString in
            defer { expView.fulfill() }
            XCTAssertEqual(userString, "Current user: " + userMock.name)
        }

        viewModel.fetchUserButtonTapped()

        waitForExpectations(timeout: 0.1)
    }
}

ViewModelTests.defaultTestSuite.run() // please add this if you are using playground
