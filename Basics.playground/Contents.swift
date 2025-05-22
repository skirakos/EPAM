//let possibleNumber: Int? = 123
//
//if let actualNumber = possibleNumber {
//    print("The number is \(possibleNumber)")
//} else {
//    print("No valid number")
//}

//if let actualNumber = possibleNumber {
//    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
//} else {
//    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
//}

//var greeting = "Hello, world!"
//var beginning = greeting.prefix(5) // Substring → "Hello"
//beginning.remove(at: beginning.startIndex)
//beginning.insert("k", at: beginning.startIndex)
//
//print(beginning) // "Hello"
//print(greeting)
//let newString = String(beginning)  // New String → also "Hello"
//let dogString = "Dog!!🐶"
//for codeUnit in dogString.utf8 {
//    print("\(codeUnit) ", terminator: "")
//}
//print("")
//for codeUnit in dogString{
//    print("\(codeUnit) ", terminator: "")
//}
//
//var favoriteGenres: Set = ["Rock", "Classical", "Hip hop", "Rock"]
//for i in favoriteGenres {
//    print(i)
//    
//}
//let minutes = 59
//let minuteInterval = 5
//for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
//    print("\(tickMark):00")
//}
let name: String? = nil
guard let name = name else {
        print("No name provided.")
        return
}
print("Hello, \(name)!")
