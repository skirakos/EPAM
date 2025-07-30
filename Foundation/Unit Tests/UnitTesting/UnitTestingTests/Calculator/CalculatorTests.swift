//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let result = try calculator.divide(200, 2.5)
        XCTAssertEqual(80, result)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(200, 0)) { error in
                XCTAssertEqual(error as? Calculator.CalculatorError, .divisionByZero)
            }
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        let a = 8
        let b = 10
        let c = 118
        
        XCTAssertFalse(calculator.isGreaterThanTen(a))
        XCTAssertFalse(calculator.isGreaterThanTen(b))
        XCTAssertTrue(calculator.isGreaterThanTen(c))
    }

    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let result = calculator.safeSquareRoot(16)
        XCTAssertNotNil(result)
        XCTAssertEqual(result!, 4)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let result = calculator.safeSquareRoot(-16)
        XCTAssertNil(result)
    }
}
