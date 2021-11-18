//
//  PokeModel.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import Foundation

struct PokeModel {

    let api: PokeAPI

    init(api: PokeAPI) {
        self.api = api
    }

    func getListOfPokemons(limit: Int, completion: @escaping (([Pokemon]) -> Void)) {
        var pokemons: [Pokemon] = []

        let group = DispatchGroup()

        group.enter()
        self.api.get(url: "pokemon?limit=\(limit)", onCompletion: { (list: PokemonList?, _) in
            guard let list = list else {
                group.leave()
                return
            }
            list.results.forEach { result in
                group.enter()
                self.api.get(url: "/pokemon/\(result.id)/", onCompletion: { (pokemon: Pokemon?, _) in
                    guard let pokemon = pokemon else {
                        group.leave()
                        return
                    }
                    pokemons.append(pokemon)
                    group.leave()
                })
            }
            group.leave()
        })

        group.notify(queue: .main) {
            completion(pokemons)
        }
    }

}
