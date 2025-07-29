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

class ViewModelExpertHardTest2: XCTestCase {
    func testBasics() async {
        let model = ViewModelExpert()
        let task = Task { await model.onAppear() }
    }
}
