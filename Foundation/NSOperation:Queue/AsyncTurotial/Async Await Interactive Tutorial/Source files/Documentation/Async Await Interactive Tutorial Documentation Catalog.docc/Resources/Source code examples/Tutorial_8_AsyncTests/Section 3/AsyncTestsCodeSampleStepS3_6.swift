import Foundation

class ViewModelExpert {
  var count = 0

  @MainActor
  func onAppear() async {
    let screenshots = NotificationCenter.default.notifications(
      named: UIApplication.userDidTakeScreenshotNotification
    )
    for await _ in screenshots {
      self.count += 1
    }
  }
}

import XCTest

class ViewModelExpertTests: XCTestCase {
    @MainActor
    func testBasics() async {
        let model = ViewModelExpert()
        let task = Task { @MainActor in await model.onAppear() }

        // Give the task an opportunity to start executing its work.
        await Task.yield()

        // Simulate a screen shot being taken.
        await NotificationCenter.default.post(
            name: UIApplication.userDidTakeScreenshotNotification, object: nil
          )

        // Give the task an opportunity to update the view model.
          await Task.yield()

          XCTAssertEqual(model.count, 1)
    }
}
