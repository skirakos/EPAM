import Foundation

actor Counter {
    var value: Int = 1

    func increment() {
        value += 1
    }

    func decrement() async {
        if value > 0 {
            await Task.yield()
            value -= 1
        }
    }
}

func funWithActors() {
    Task {
        let actor = Counter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<100 {
                group.addTask {
                    await actor.increment()
                }
            }

            for _ in 0..<100 {
                group.addTask {
                    await actor.decrement()
                }
            }
        }

        print(await actor.value)
    }
}
