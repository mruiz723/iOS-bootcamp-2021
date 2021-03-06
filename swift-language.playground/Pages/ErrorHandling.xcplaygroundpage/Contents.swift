//: [GenericsII](@previous)

import Foundation

// Error Handling (throw, do try catch, error to optional value)

enum SpeakError: Error {
    case cantSpeak
}
struct Speaker {
    func speak() {
        print("hi!")
    }
}

func tryToSpeak(instance: Speaker?) throws {
    if instance == nil {
        throw SpeakError.cantSpeak
    }
    instance?.speak()
}

do {
    try tryToSpeak(instance: nil)
    try tryToSpeak(instance: Speaker())
} catch {
    print(error)
}

// Representing Errors

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// Propagating Errors Using Throwing Functions

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// Handling Errors Using Do-Catch

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Couldn't buy that from the vending machine."

func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

// Converting Errors to Optional Values

func someThrowingFunction() throws -> Int {
    // ...
    throw VendingMachineError.outOfStock
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

enum NetworkError: Error {
    case invalidPath
    case invalidURL
    case invalidCode
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

func fetchDataFromDisk() throws -> Data? {
    throw NetworkError.invalidPath
}

func fetchDataFromServer() throws -> Data? {
    throw NetworkError.invalidURL
}

// Disabling Error Propagation

// let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

// Specifying Cleanup Actions

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
            print(line)
        }
        // close(file) is called here, at the end of the scope.
    }
}

func exists(_ filename: String) -> Bool {
    return true
}

func open(_ filename: String) -> File {
    // open file
    return File(filename)
}

func close(_ file: File) {
    // close file
}

class File {
    let fileName: String

    init(_ filename: String) {
        self.fileName = filename
    }

    func readline() throws -> String? {
        throw NetworkError.invalidCode
    }
}

do {
    try processFile(filename: "test")
} catch {
    print(error)
}

//: [Codable](@next)
