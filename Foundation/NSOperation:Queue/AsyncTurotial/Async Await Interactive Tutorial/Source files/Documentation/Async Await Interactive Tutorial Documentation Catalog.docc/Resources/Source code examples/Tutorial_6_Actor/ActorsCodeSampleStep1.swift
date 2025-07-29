import Foundation

actor Counter {
    var value: Int = 1

    func increment() {
        value += 1
    }

    func decrement() {
        value -= 1
    }
}
