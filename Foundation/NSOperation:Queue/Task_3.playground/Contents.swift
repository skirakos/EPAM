import Foundation

let opB = BlockOperation {
    print("Operation \"B\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    print("Operation \"B\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let opA = BlockOperation {
    print("Operation \"A\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
    // do nothing
    }
    opB.cancel()
    print("Operation \"A\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

//opB.addDependency(opA)

let queue = OperationQueue()

queue.addOperation(opA)
queue.addOperation(opB)
