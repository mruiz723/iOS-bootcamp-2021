//
//  Endpoint.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 28/02/21.
//

import Foundation
import PokemonAPI

struct Endpoint {

    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = [URLQueryItem]()) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {

    static func pokemons() -> Endpoint {
        let offsetItem: URLQueryItem = URLQueryItem(name: Constants.offset, value: String(PokemonAPI.pokemonsOffset))
        let limitItem: URLQueryItem = URLQueryItem(name: Constants.limit, value: String(PokemonAPI.limit))
        PokemonAPI.pokemonsOffset += PokemonAPI.limit

        return Endpoint(
            path: "/api/v2/pokemon", queryItems: [offsetItem, limitItem]
        )
    }

    static func moves() -> Endpoint {
        let offsetItem: URLQueryItem = URLQueryItem(name: Constants.offset, value: String(PokemonAPI.movesOffset))
        let limitItem: URLQueryItem = URLQueryItem(name: Constants.limit, value: String(PokemonAPI.limit))
        PokemonAPI.movesOffset += PokemonAPI.limit

        return Endpoint(
            path: "/api/v2/move", queryItems: [offsetItem, limitItem]
        )
    }
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.path = path
        components.queryItems = queryItems.count > 0 ? queryItems : nil

        return components.url
    }
}
