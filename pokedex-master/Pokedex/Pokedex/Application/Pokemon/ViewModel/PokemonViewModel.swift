//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 28/02/21.
//

import Foundation
import PokemonAPI
import Combine
import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemons = [PKMPokemon]()
    @Published var isLoadingPage = false
    var pokemonsCopy = [PKMPokemon]()

    private var subscriptions: Set<AnyCancellable> = []
    private var pageObject: PageObject?

    func filterPokemons(name: String?) {
        if pokemonsCopy.count == 0 {
            pokemonsCopy = pokemons
        }
        guard let name = name, name.count > 0 else {
            pokemons = pokemonsCopy
            return
        }

        pokemons = pokemons.filter { pokemon in
            (pokemon.name?.lowercased().contains(name.lowercased()) ?? false)
        }
    }

    func fetchPokemons() {
        isLoadingPage = true
        guard PokemonAPI.pokemonsOffset + PokemonAPI.limit <= PokemonAPI.count, let url = Endpoint.pokemons().url else { return }
        var newPokemons: [PKMPokemon] = []

        PokemonAPI.fetchPokemonList(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { pageObject in
                self.pageObject = pageObject
                PokemonAPI.count = pageObject.count

                pageObject.results?.forEach { [weak self] namedAPIResource  in
                    guard let self = self else { return }
                    print("loading \(namedAPIResource.url)")
                    self.fetchPokemon(by: namedAPIResource.name)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                print("failed: \(error)")
                            }
                        }, receiveValue: { pokemon in
                            print("type: \(String(describing: pokemon.types?.first?.type?.name))")
                            newPokemons.append(pokemon)
                            if newPokemons.count == PokemonAPI.limit {
                                self.isLoadingPage = false
                                self.pokemons.removeAll()
                                newPokemons.sort(by: {
                                    $0.id! < $1.id!
                                })
                                print("pokemons: \(newPokemons.count)")
                                self.pokemons.append(contentsOf: newPokemons)
                            }

                        }).store(in: &self.subscriptions)
                }
            }).store(in: &subscriptions)
    }

    func fetchPokemon(by name: String) -> AnyPublisher<PKMPokemon, Error> {
        return PokemonAPI().pokemonService.fetchPokemon(name)
    }

    // Initial shimmer data
    // Showing until data is loading
    func loadTempData() {
        var pokemons: [PKMPokemon] = []

        for _ in 1...20 {
            guard let temp = PKMPokemon.pokemonMock() else { return }
            pokemons.append(temp)
        }

        self.pokemons = pokemons
    }

    func fetchMoreListPockemons() {
        guard !isLoadingPage, let shimmerPokemon = PKMPokemon.pokemonMock(), let url = Endpoint.pokemons().url else { return }
        isLoadingPage = true
        pokemons.append(shimmerPokemon)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            guard PokemonAPI.pokemonsOffset + PokemonAPI.limit <= PokemonAPI.count else { return }
            var newPokemons: [PKMPokemon] = []

            PokemonAPI.fetchPokemonList(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print(error.localizedDescription)
                    }
                }, receiveValue: { pageObject in
                    self.pageObject = pageObject
                    PokemonAPI.count = pageObject.count
                    pageObject.results?.forEach { [weak self] namedAPIResource  in
                        print("loading \(namedAPIResource.url)")
                        guard let self = self else { return }
                        self.fetchPokemon(by: namedAPIResource.name)
                            .receive(on: DispatchQueue.main)
                            .sink(receiveCompletion: { completion in
                                switch completion {
                                case .finished:
                                    break
                                case .failure(let error):
                                    print("failed: \(error)")
                                }
                            }, receiveValue: { pokemon in
                                newPokemons.append(pokemon)
                                if newPokemons.count == PokemonAPI.limit {
                                    self.isLoadingPage = false
                                    self.pokemons.removeLast()
                                    newPokemons.sort(by: {
                                        $0.id! < $1.id!
                                    })
                                    print("pokemons: \(newPokemons.count)")
                                    self.pokemons.append(contentsOf: newPokemons)
                                }
                            }).store(in: &self.subscriptions)
                    }
                }).store(in: &self.subscriptions)
        }
    }
}
