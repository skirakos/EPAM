public var uncheckedUseMainSerialExecutor: Bool {
  get { swift_task_enqueueGlobal_hook != nil }
  set {
    swift_task_enqueueGlobal_hook =
      newValue
      ? { job, _ in MainActor.shared.enqueue(job) }
      : nil
  }
}
