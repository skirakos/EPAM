//
//  task-2.swift
//  
//
//  Created by Seda Kirakosyan on 26.05.25.
//

import Foundation

public func isBalancedParentheses(input: String) -> Bool {
    let len = input.count
    var i = 0
    var j = len - 1
    if input.filter { $0 == "(" }.count !=  input.filter { $0 == ")" }.count {
        return false
    }
    while  i <= j {
        let leftIndex = input.index(input.startIndex, offsetBy: i)
        let rightIndex = input.index(input.startIndex, offsetBy: j)
        
        if input[leftIndex] == "(" {
            while i < j && input[rightIndex] != ")" {
                j -= 1
                if j < i {
                    return false
                }
            }
            if input[rightIndex] != ")" {
                return false
            }
            i += 1
            j -= 1
        } else if input[leftIndex] == ")" {
            return false
        } else {
            i += 1
        }
    }
    return true
}
