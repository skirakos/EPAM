class ViewModelCancellationTests: XCTestCase {
    var viewModel: ViewModelCancellation!
    var serviceMock: MockUserService!

    override func setUp() async throws {
        serviceMock = MockUserService()
        viewModel = ViewModelHard(userService: serviceMock)
    }


    func testCancellation() async -> Void {
        let exp = expectation(description: "stream should be ended")
        serviceMock.fetchSomeDataClosure = {
            let (stream, _) = AsyncStream.makeStream(of: String.self)
            for await _ in stream {
                XCTFail("This one should be cancelled")
            }

            exp.fulfill()
            throw CancellationError()
        }
        viewModel.fetchUserButtonTapped()
        viewModel.fetchUserButtonTapped()
        await fulfillment(of: [exp], timeout: 0.1)
    }
}
