import Foundation

func executeOperationAndCallCompletion(
    waitUntil operation: @escaping @Sendable () async throws -> Void,
    completion: @escaping @Sendable () -> Void) {
        Task { @MainActor in
            do {
                try await operation()
                completion()
            } catch {
                completion()
            }
        }
    }

let completion = { @Sendable in
    if !Thread.current.isMainThread {
        print("Completion: execution happens not on the Main thread")
    }
}
