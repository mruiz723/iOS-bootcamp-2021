//
//  PokemonAPI+Fetching.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 28/02/21.
//

import Foundation
import Combine
import PokemonAPI

extension PokemonAPI {
    static var pokemonsOffset = 0
    static var movesOffset = 0
    static let limit = 20
    static var count = 20

    // https://pokeapi.co/api/v2/pokemon?offset=20&limit=20
    static func fetchPokemonList(url: URL) -> AnyPublisher<PageObject, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: {
                print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!)                
            })
            .tryMap { try JSONDecoder().decode(PageObject.self, from: $0.data) }
            .eraseToAnyPublisher()
    }

    static func fetchMoveList(url: URL) -> AnyPublisher<PageObject, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: {
                print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!)
            })
            .tryMap { try JSONDecoder().decode(PageObject.self, from: $0.data) }
            .eraseToAnyPublisher()
    }
}
