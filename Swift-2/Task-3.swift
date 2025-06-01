//
//  Task-3.swift
//  
//
//  Created by Seda Kirakosyan on 01.06.25.
//

import Foundation


class Person {
    var name: String
    var age: Int
    var isAdult: Bool { age >= 18 }
    static var minAgeForEnrollment = 16
    lazy var profileDescription: String = {
        "\(name) is \(age) years old."
    }()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    convenience init?(name: String, age: Int, checkAge: Bool = true) {
        if age < Person.minAgeForEnrollment {
            return nil
        }
        self.init(name: name, age: age)
    }
}

class Student: Person {
    var studentID: String
    var major: String
    weak var advisor: Professor?
    var formattedID: String {
        "ID \(studentID.uppercased())"
    }
    
    static var studentCount: Int = 0
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        Student.studentCount += 1
    }

    convenience init?(name: String, age: Int, major: String = "Undeclared", studentID: String = "Unknown") {
        guard age >= Person.minAgeForEnrollment else {
            return nil
        }
        self.init(name: name, age: age, studentID: studentID, major: major)
    }
}

class Professor: Person {
    var faculty: String
    static var professorCount: Int = 0
    var fullTitle: String {
            return "Prof. \(name) - \(faculty)"
    }

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Professor.professorCount += 1
    }
}

struct University {
    var name: String
    var location: String
    var description: String {
        return "\(name) located in \(location)"
    }
}
