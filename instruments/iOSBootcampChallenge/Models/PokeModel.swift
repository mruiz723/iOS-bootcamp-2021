//
//  PokeModel.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import Foundation
import Combine

struct PokeModel {

    let api: PokeAPI

    init(api: PokeAPI) {
        self.api = api
    }

    func getListOfPokemons(limit: Int) -> AnyPublisher<[Pokemon], Error>? {

        let serialPublisher: AnyPublisher<PokemonList, Error>? = self.api.get(url: "/pokemon?limit=\(limit)")

        let colletion = serialPublisher?
            .map { (list: PokemonList) -> [AnyPublisher<Pokemon, Error>] in
                list.results.compactMap {
                    self.api.get(url: "/pokemon/\($0.id)/")?.eraseToAnyPublisher()
                }
            }
            .flatMap { publishers in
                publishers.publisher
            }
            .flatMap { $0 }
            .collect()

        return colletion?.eraseToAnyPublisher()
    }

}
