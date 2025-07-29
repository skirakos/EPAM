swift_task_enqueueGlobal_hook = { job, _ in
  MainActor.shared.enqueue(job)
}
