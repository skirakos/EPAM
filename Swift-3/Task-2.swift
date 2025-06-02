//
//  Task-2.swift
//  
//
//  Created by Seda Kirakosyan on 02.06.25.
//

import Foundation

struct School {
    enum SchoolRole {
        case student
        case teacher
        case administrator
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    var people: [Person] = []
    
    subscript(role: SchoolRole) -> [Person] {
        return people.filter{ $0.role == role }
    }
    
    mutating func addPerson(_ person: Person) {
        people.append(person)
    }
    
    func countStudents(school: School) -> Int {
        return school[.student].count
    }
    
    func countTeachers(school: School) -> Int {
        return school[.teacher].count
    }
    
    func countAdministrators(school: School) -> Int {
        return school[.administrator].count
    }
}

//var school = School()
//school.addPerson(School.Person(name: "Seda", role: .student))
//school.addPerson(School.Person(name: "John", role: .teacher))
//school.addPerson(School.Person(name: "Anastasiya", role: .administrator))
//school.addPerson(School.Person(name: "Alexey", role: .administrator))
//school.addPerson(School.Person(name: "Ellen", role: .student))
//school.addPerson(School.Person(name: "Susan", role: .teacher))
//school.addPerson(School.Person(name: "Jack", role: .administrator))
//
//print("Number of students: \(school.countStudents(school: school))")
//print("Number of teachers: \(school.countTeachers(school: school))")
//print("Number of administrators: \(school.countAdministrators(school: school))")
