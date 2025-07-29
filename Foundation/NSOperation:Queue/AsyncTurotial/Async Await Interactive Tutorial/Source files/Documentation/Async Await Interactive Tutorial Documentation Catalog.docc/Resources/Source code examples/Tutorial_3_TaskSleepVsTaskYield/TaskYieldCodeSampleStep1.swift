import Foundation

@MainActor
@Sendable
func veryLongRunningTaskA() async {
    for i in 0..<100 {
        print(i)
    }
}
