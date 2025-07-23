import Foundation

let op1 = BlockOperation {
    print("Operation \"A\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"A\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let op2 = BlockOperation {
    print("Operation \"B\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"B\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let op3 = BlockOperation {
    print("Operation \"C\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"C\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let op4 = BlockOperation {
    print("Operation \"D\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"D\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let op5 = BlockOperation {
    print("Operation \"E\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"E\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

op2.addDependency(op3)
op4.addDependency(op2)
op1.queuePriority = .low

let queue = OperationQueue()
queue.addOperations([op1, op2, op3, op4, op5], waitUntilFinished: true)
//queue.maxConcurrentOperationCount = 6
queue.maxConcurrentOperationCount = 2

