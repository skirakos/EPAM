//
//  task-1.swift
//  
//
//  Created by Seda Kirakosyan on 25.05.25.
//

import Foundation

public func isPalindrome(input: String) -> Bool {
    var j = input.count;
    let lowercaseString = input.lowercased()

    var i: Int = 0
    j -= 1
    let validCharCount = lowercaseString.filter { $0.isLetter || $0.isNumber }.count
    if validCharCount < 2 {
        return false
    }
    while i < j {
        let leftIndex = lowercaseString.index(lowercaseString.startIndex, offsetBy: i)
        let rightIndex = lowercaseString.index(lowercaseString.startIndex, offsetBy: j)
        if !(lowercaseString[leftIndex].isLetter ||  lowercaseString[leftIndex].isNumber) {
            i += 1
            continue
        }
        else if !(lowercaseString[rightIndex].isLetter ||  lowercaseString[rightIndex].isNumber) {
            j -= 1
            continue
        }
        if lowercaseString[leftIndex] != lowercaseString[rightIndex] {
            return false
        }
        i += 1
        j -= 1
    }
    return true
}
