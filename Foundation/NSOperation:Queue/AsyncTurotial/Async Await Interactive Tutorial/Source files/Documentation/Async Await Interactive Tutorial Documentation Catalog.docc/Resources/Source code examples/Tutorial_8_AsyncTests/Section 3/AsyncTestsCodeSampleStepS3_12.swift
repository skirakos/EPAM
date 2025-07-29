/*
1. Remembers any hook that was there before your code
2. Sets uncheckedUseMainSerialExecutor to `true` which will force all async code run on @MainActor
3. Runs your code in `{... }` code section
4. Restores previous hook after it
*/

@MainActor
public func withMainSerialExecutor(
  @_implicitSelfCapture operation: @MainActor @Sendable () async throws -> Void
) async rethrows {
  //(1)
  let didUseMainSerialExecutor = uncheckedUseMainSerialExecutor
  //(4)
  defer { uncheckedUseMainSerialExecutor = didUseMainSerialExecutor }
  //(2)
  uncheckedUseMainSerialExecutor = true
  //(3)
  try await operation()
}
