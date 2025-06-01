//
//  Task-2.swift
//
//
//  Created by Seda Kirakosyan on 01.06.25.
//

class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    convenience init?(name: String, age: Int, checkAge: Bool = true) {
        if age < 16 {
            return nil
        }
        self.init(name: name, age: age)
    }
}

class Student: Person {
    var studentID: String
    var major: String
    
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
    }

    convenience init?(name: String, age: Int, major: String = "Undeclared", studentID: String = "Unknown") {
        guard age >= 16 else {
            return nil
        }
        self.init(name: name, age: age, studentID: studentID, major: major)
    }
}

class Professor: Person {
    var faculty: String
    
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
}

struct University {
    var name: String
    var location: String
}
