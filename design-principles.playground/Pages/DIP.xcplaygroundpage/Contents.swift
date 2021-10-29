//: [ISP](@previous)

import Foundation


//    Dependency Inversion Principle
//    Entities must depend on abstractions, not on concretions.
//    It states that the high-level module must not depend on the low-level module,
//    but they should depend on abstractions.

struct User {
    let id: String
    let name: String
}

protocol DatabaseService {
  func getUsers() -> [User]
}

class CoreDataService: DatabaseService {
    func getUsers() -> [User] {
        // Get user from Core Data
        return [User]()
    }
}

class RealmService: DatabaseService {
    func getUsers() -> [User] {
        // Get user from Realm
        return [User]()
    }
}

let databaseService: DatabaseService = CoreDataService()
