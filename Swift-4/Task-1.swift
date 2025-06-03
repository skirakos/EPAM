//
//  Task-1.swift
//  
//
//  Created by Seda Kirakosyan on 04.06.25.
//

import Foundation

class Stack<T> {
    var items: [T] = []
    
    init(items: [T]) {
        self.items = items
    }
    
    func push(_ element: T) {
        self.items.append(element)
    }
    
    func pop() -> T? {
        if self.items.isEmpty {
            print("Stack is empty. Cannot pop.")
            return nil
        }
        return items.popLast()
    }
    
    func size() -> Int {
        return self.items.count
    }
    
    func printStackContents() -> String {
        if self.items.isEmpty {
            print("Nothing to print. Stack is empty.")
            return ""
        }
        var stringToPrint: String = ""
        for item in self.items {
            stringToPrint += "\(item)"
            stringToPrint += " "
        }
        return stringToPrint
    }
}
