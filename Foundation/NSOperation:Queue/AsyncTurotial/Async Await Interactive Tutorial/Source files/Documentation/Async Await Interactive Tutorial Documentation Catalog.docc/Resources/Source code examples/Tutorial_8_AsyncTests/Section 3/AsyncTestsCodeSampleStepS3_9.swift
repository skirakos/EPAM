void swift::swift_task_enqueueGlobal(Job *job) {
  _swift_tsan_release(job);

  concurrency::trace::job_enqueue_global(job);

  if (swift_task_enqueueGlobal_hook)
    swift_task_enqueueGlobal_hook(
      job, swift_task_enqueueGlobalImpl
    );
  else
    swift_task_enqueueGlobalImpl(job);
}
