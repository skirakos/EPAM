//
//  Task-1.swift
//  
//
//  Created by Seda Kirakosyan on 02.06.25.
//

import Foundation

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    mutating func checkIn()
    func isOverdue() -> Bool
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let dueDate = returnDate else { return false }
        return Date() > dueDate
    }
    
    mutating func checkIn() {
        self.borrowDate = nil
        self.returnDate = nil
        isBorrowed = false
        print("Item has been checked in.")
    }
}

class Item {
    let id = UUID()
    let title : String
    let author : String
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
}

enum LibraryError: Error {
    case itemNotFound
    case alreadyBorrowed
    case itemNotBorrowable
    
}

class Library {
    var items: [String:Item] = [:]
    
    func addBook(_ book: Book) {
        items[book.id.uuidString] = book
    }
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard let borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        if let book = item as? Book {
            book.isBorrowed = true
            book.borrowDate = Date()
            book.returnDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
        }
        print("Item '\(item.title)' has been borrowed.")
        return item
    }
}

let book = Book(title: "Lord of Rings", author: "Mark Smith")

let library = Library()
library.addBook(book)
library.addBook(book)

do {
    try library.borrowItem(by: book.id.uuidString)
} catch {
    print("Error: \(error)")
}
