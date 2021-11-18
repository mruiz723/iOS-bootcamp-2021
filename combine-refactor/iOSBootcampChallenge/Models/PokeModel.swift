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

    func getListOfPokemons(limit: Int) -> AnyPublisher<[Pokemon], Error>? // Publishers.Collect<Publishers.FlatMap<Publishers.Sequence<[Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, Pokemon, JSONDecoder>], Never>.Output, Publishers.FlatMap<Publishers.SetFailureType<Publishers.Sequence<[Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, Pokemon, JSONDecoder>], Never>, Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, PokemonList, JSONDecoder>.Failure>, Publishers.Map<Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, PokemonList, JSONDecoder>, [Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, Pokemon, JSONDecoder>]>>>>
    {

        guard
            let serialPublisher: Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, PokemonList, JSONDecoder> = self.api.get(url: "/pokemon?limit=\(limit)")
        else { return nil }

        let colletion = serialPublisher
            .map { (list: PokemonList) -> [Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, Pokemon, JSONDecoder>] in
                list.results.compactMap {
                    self.api.get(url: "/pokemon/\($0.id)/")
                }
            }
            .flatMap { publishers in
                publishers.publisher
            }
            .flatMap { $0 }
            .collect()

        return AnyPublisher(colletion)
    }

}
