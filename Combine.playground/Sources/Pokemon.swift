//
//  Pokemon.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

// MARK: - Pokemon

public struct Pokemon: Decodable, Equatable {

    let id: Int
    let name: String
    let image: String?
    let types: [String]?
    let abilities: [String]?
    let weight: Float
    let baseExperience: Int

    init(id: Int,
         name: String,
         image: String?,
         types: [String]?,
         abilities: [String]?,
         weight: Float,
         baseExperience: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.types = types
        self.abilities = abilities
        self.weight = weight
        self.baseExperience = baseExperience
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case type
        case types
        case sprites
        case other
        case officialArtwork = "official-artwork"
        case frontDefault = "front_default"
        case abilities
        case ability
        case weight
        case baseExperience = "base_experience"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let sprites = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let other = try sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtWork = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        self.image = try? officialArtWork.decode(String.self, forKey: .frontDefault)

        var typesArray = try container.nestedUnkeyedContainer(forKey: .types)
        var pokeTypes: [String] = []

        while !typesArray.isAtEnd {
            let typesContainer = try typesArray.nestedContainer(keyedBy: CodingKeys.self)
            let typeContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
            pokeTypes.append(try typeContainer.decode(String.self, forKey: .name))
        }

        self.types = pokeTypes

        var abilitiesArray = try container.nestedUnkeyedContainer(forKey: .abilities)
        var pokeAbilities: [String] = []

        while !abilitiesArray.isAtEnd {
            let abilitiesContainer = try abilitiesArray.nestedContainer(keyedBy: CodingKeys.self)
            let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .ability)
            pokeAbilities.append(try abilityContainer.decode(String.self, forKey: .name).capitalized)
        }

        self.abilities = pokeAbilities

        self.weight = try container.decode(Float.self, forKey: .weight)
        self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
    }

}
