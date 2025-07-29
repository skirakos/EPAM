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
