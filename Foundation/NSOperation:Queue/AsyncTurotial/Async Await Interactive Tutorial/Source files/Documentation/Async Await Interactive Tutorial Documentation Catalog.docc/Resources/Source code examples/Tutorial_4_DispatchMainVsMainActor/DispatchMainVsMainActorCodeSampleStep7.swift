import Foundation

func executeOperationAndCallCompletion(
    waitUntil operation: @escaping @Sendable @MainActor () async throws -> Void,
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
    dispatchPrecondition(condition: .onQueue(.main))
    print("Completion: execution happens on the Main thread")
}

executeOperationAndCallCompletion(waitUntil: {
    print("Operation started")

    dispatchPrecondition(condition: .notOnQueue(.main))
    print("Completion: execution happens not on the Main thread")

}, completion: completion)
