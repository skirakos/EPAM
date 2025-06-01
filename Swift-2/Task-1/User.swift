//
//  File.swift
//  
//
//  Created by Seda Kirakosyan on 31.05.25.
//

import Foundation

struct User {
    var username : String;
    var email : String;
    var password : String;
}

class UserManager {
    var users : [String: User]
    var userCount : Int {
        return users.count
    }
    
    init(users: [String : User]) {
        self.users = users
    }
    init() {
        self.users = [:]
    }
    func registerUser(username: String, email: String, password: String) -> Bool {
        guard users[username] == nil else {
            print("User '\(username)' already exists.")
            return false
        }
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        print("User \(username) registered successfully.")
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("User '\(username)' not found.")
            return false
        }
        if user.password == password {
            print("User logged in successfully.")
            return true
        } else {
            print("Incorrect password: User login failed.")
            return false
        }
    }
    
    func removeUser(username: String) -> Bool {
        if let _ = users[username] {
            users.removeValue(forKey: username)
            print("User '\(username)' removed.")
            return true
        } else {
            print("User '\(username)' not found.")
            return false
        }
    }
}

class AdminUser : UserManager {
    func listAllUsers() -> [String] {
        var lst: [String] = []
        for (username, _) in users {
            lst.append(username)
        }
        return lst
    }
    
    deinit {
        print("This Admin was removed.")
    }
}

//let admin = AdminUser()
//
//// Register users
//admin.registerUser(username: "alice", email: "alice@example.com", password: "pass123")
//admin.registerUser(username: "bob", email: "bob@example.com", password: "pass456")
//
//// List all users
//print("All users: \(admin.listAllUsers())")
//
//// Login
//admin.login(username: "alice", password: "pass123")
//admin.login(username: "bob", password: "wrongpass")
//
//// Remove a user
//admin.removeUser(username: "alice")
//
//let lst = admin.listAllUsers()
//print(lst)
//print("User count: \(admin.userCount)")
