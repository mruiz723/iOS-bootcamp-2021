//: [CodableIII](@previous)

import Foundation

// Encoding & DecodingStrategy

let jsonString = """
{
    "abilities": [
        {
            "ability": {
                "name": "overgrow",
                "url": "https://pokeapi.co/api/v2/ability/65/"
            },
            "is_hidden": false,
            "slot": 1
        },
        {
            "ability": {
                "name": "chlorophyll",
                "url": "https://pokeapi.co/api/v2/ability/34/"
            },
            "is_hidden": true,
            "slot": 3
        }
    ],
    "base_experience": 64,
    "forms": [
        {
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon-form/1/"
        }
    ]
}
"""

struct Item: Codable {
    let name: String
    let url: String
}

struct Ability: Codable {
    let ability: Item
    let isHidden: Bool
    let slot: Int
}

struct Pokemon: Codable {
    let abilities: [Ability]
    let forms: [Item]
    let baseExperience: Int

    enum CodingKeys: CodingKey {
        case abilities
        case forms
        case baseExperience
    }
}

let data = Data(jsonString.utf8)
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let coordinate = try decoder.decode(Pokemon.self, from: data)

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase
let dataEncoded = try encoder.encode(coordinate)
let jsonString2 = String(data: dataEncoded, encoding: .utf8)

//: [Concurrency](@next)

