//
//  main.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 23.07.25.
//

import Foundation

class OperationTest {
    let customQueue = OperationQueue()

    func runExample() {
        let operation = BlockOperation {
            print("Operation \"A\" started on thread: \(Thread.current)")
            
            for _ in 0..<1_000_000 {
                // do nothing
            }

            print("Operation \"A\" finished on thread: \(Thread.current)")
        }
//         OperationQueue.main.addOperation(operation)

        customQueue.addOperation(operation)
    }
}

let test = OperationTest()
test.runExample()

RunLoop.main.run(until: Date().addingTimeInterval(1))
