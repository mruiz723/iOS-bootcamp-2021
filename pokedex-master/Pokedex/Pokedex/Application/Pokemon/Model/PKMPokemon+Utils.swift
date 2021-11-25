//
//  PKMPokemon+Utils.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 27/02/21.
//

import SwiftUI
import PokemonAPI

enum PokemonType: String, Decodable, CaseIterable, Identifiable {
    var id: String { rawValue }

    case fire = "fire"
    case grass = "grass"
    case water = "water"
    case poison = "poison"
    case flying = "flying"
    case electric = "electric"
    case bug = "bug"
    case normal = "normal"
}

extension PKMPokemon {
    func formattedNumber() -> String {
        String(format: "#%03d", arguments: [id ?? 0])
    }

    func primaryType() -> String? {
        guard let primary = types?.first else { return nil }
        return primary.type?.name?.capitalized
    }

    func secondaryType() -> String? {
        let index = 2
        guard index < types?.count ?? 0, let secondary = types?[2] else { return nil }
        return secondary.type?.name?.capitalized
    }

    static func pokemonMock() -> PKMPokemon? {
        guard let path = Bundle.main.path(forResource: "bulbasaur", ofType: "json") else { return nil }

        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("failed data")
            return nil

        }
        
        guard let pokemon: PKMPokemon = try? PKMPokemon.decoder.decode(PKMPokemon.self, from: jsonData) else {
            print("failed decoder")
            return nil
        }
        
        return pokemon
    }
}
