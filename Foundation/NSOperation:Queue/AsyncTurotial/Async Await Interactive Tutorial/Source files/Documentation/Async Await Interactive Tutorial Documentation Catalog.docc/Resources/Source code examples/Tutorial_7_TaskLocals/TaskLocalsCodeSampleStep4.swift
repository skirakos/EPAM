import Foundation

enum MyLocals {
    @TaskLocal static var id: Int!
}

func funWithLocals() {
    MyLocals.$id.withValue(42) {
        print("withValue:", MyLocals.id!)
        Task {
            MyLocals.$id.withValue(1729) {

            }
        }
    }
}
