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
import ConcurrencyExtras
class ViewModelExpertTests: XCTestCase {
    override func invokeTest() {
        withMainSerialExecutor {
            super.invokeTest()
        }
    }

    func testBasics() async {
        let model = ViewModelExpert()
        let task = Task { await model.onAppear() }

        // Give the task an opportunity to start executing its work.
        await Task.yield()

        await NotificationCenter.default.post(
            name: UIApplication.userDidTakeScreenshotNotification, object: nil
        )

        // Give the task an opportunity to update the view model.
        await Task.yield()

        XCTAssertEqual(model.count, 1)
    }
}
