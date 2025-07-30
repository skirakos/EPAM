import Foundation

func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("Task \(taskNumber) started")
    sleep(delay) // Simulate work
    print("Task \(taskNumber) finished")
}

func executeTasks() {
    let queue1 = DispatchQueue(label: "com.example.queue1", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue2", attributes: .concurrent)
    let queueFinal = DispatchQueue(label: "com.example.finalQueue")
    let group = DispatchGroup()
    
        
    queue1.async {
        group.enter()
        executeTask(1, delay: 2)
        group.leave()
    }
    
    queue2.async {
        group.enter()
        executeTask(2, delay: 3)
        group.leave()
    }
    
    group.notify(queue: queueFinal) {
        executeTask(3, delay: 1)
    }
}

// Run the function
executeTasks()
//
//Calling group.enter() outside the async block can lead to issues. If the async block is never executed (e.g., the queue is suspended or there's an early return), group.leave() will never be called, causing the group to hang indefinitely. It's safer to call group.enter() inside the async block to guarantee that every enter has a matching leave.
