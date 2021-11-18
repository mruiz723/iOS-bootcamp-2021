//
//  DetailViewModel.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import Foundation

class DetailViewModel {

    private let pokemon: Pokemon

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    var primaryType: String? {
        pokemon.primaryType()
    }

    var pokemonName: String {
        pokemon.name.capitalized
    }

    var pokemonID: String {
        pokemon.formattedNumber()
    }

    var pokemonTypes: [String] {
        pokemon.types ?? []
    }

    var pokemonImageURL: URL? {
        guard let string = pokemon.image else { return nil }
        return URL(string: string)
    }

    var pokemonAbilities: [String] {
        pokemon.abilities ?? []
    }

    var pokemonWeight: String {
        "\(pokemon.weight/10) kg"
    }

    var pokemonExperience: String {
        "\(pokemon.baseExperience)"
    }

}
