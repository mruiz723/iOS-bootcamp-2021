//
//  RealmService.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import Foundation

class RealmService: DatabaseServiceProtocol {
    func getUsers() -> [User] {
        return [
            User(id: 1, name: "Maria"),
            User(id: 1, name: "Munich"),
            User(id: 1, name: "Nicole"),
            User(id: 1, name: "Julia"),
            User(id: 1, name: "Lucy")
        ]
    }
}
