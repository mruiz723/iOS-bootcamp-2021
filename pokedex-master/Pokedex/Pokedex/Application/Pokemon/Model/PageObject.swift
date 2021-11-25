//
//  PageObject.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 28/02/21.
//

import Foundation

struct PageObject: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [NamedAPIResource]?
}
