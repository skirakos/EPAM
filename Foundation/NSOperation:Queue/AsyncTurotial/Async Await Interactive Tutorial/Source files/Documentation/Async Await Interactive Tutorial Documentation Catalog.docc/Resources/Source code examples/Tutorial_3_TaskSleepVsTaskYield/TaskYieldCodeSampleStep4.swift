import Foundation

@MainActor
@Sendable
func veryLongRunningTaskA() async {
    for i in 0..<100 {
        print(i)
    }
}

@MainActor
@Sendable
func veryLongRunningTaskB() async {
    for i in 200 ..<300 {
        print(i)
    }
}

func executeBoth() {
    Task { @MainActor in
        await veryLongRunningTaskA()
    }

    Task { @MainActor in
        await veryLongRunningTaskB()
    }
}

executeBoth()
