//
//  CoreDataService.swift
//  dependency-injection
//
//  Created by Marlon David Ruiz Arroyave on 3/11/21.
//

import Foundation

class CoreDataService: DatabaseServiceProtocol {
    func getUsers() -> [User] {
        return [
            User(id: 1, name: "Juan"),
            User(id: 1, name: "Michael"),
            User(id: 1, name: "Nicole"),
            User(id: 1, name: "Cristiano"),
            User(id: 1, name: "Lucas")
        ]
    }
}
