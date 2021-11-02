//
//  User.swift
//  ui-components
//
//  Created by Jorge Benavides on 02/11/21.
//

import Foundation

class User {
    var firstName: String?
    var lastName: String?
    
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    var options: Int = 8
}
