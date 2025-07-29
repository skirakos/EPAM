import Foundation

enum MyLocals {
    @TaskLocal static var id: Int!
}

func funWithLocals() {
    MyLocals.$id.withValue(42) {
        print("withValue:", MyLocals.id!)
        Task {
            MyLocals.$id.withValue(1729) {
                Task {
                    try await Task.sleep(for: .seconds(2))
                    print("Task 2:", MyLocals.id!)
                }
            }

            try await TTask.sleep(for: .seconds(1))
            Task {
                print("Task:", MyLocals.id!)
            }
        }
    }
}
