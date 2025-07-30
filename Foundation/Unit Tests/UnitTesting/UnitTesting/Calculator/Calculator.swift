//
//  Calculator.swift
//  UnitTesting
//

import Foundation

final class Calculator {
    enum CalculatorError: Error, Equatable {
        case divisionByZero
    }

    func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }

    func divide(_ a: Double, _ b: Double) throws -> Double {
        if b == 0 {
            throw CalculatorError.divisionByZero
        }
        return Double(a / b)
    }

    func isGreaterThanTen(_ number: Int) -> Bool {
        return number > 10
    }

    func safeSquareRoot(_ number: Double) -> Double? {
        return number >= 0 ? sqrt(number) : nil
    }
}
