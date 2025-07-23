//
//  main.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 23.07.25.
//

import Foundation

let op = BlockOperation {
    print(Thread.current)
    print("Operation \"A\" started")
    for _ in 0..<1000000 {
     // do nothing
    }
    print("Operation \"A\" finished")
}


//let queue = OperationQueue()
let queue = OperationQueue.main
queue.addOperation(op)
