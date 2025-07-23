import Foundation

func fetchData(from source: String, completion: @escaping () -> Void) {
    print("\(source) - Fetching data...")
    sleep(2) // Simulate network delay
    print("\(source) - Data fetched ✅")
    completion()
}

func runGCDTask() {
    let queue = DispatchQueue.global(qos: .userInitiated)
    let group = DispatchGroup()
    let sources = ["API 1", "API 2", "API 3"]

    for source in sources {
        group.enter()
        queue.async {
            fetchData(from: source) {
                print("\(source) - Processing complete")
                group.leave()
            }
        }
    }

    group.notify(queue: .main) {
        print("✅ All tasks started. Updating UI...")
    }
}

runGCDTask()
