//
//  PokemonsInteractor.swift
//  VIPPokemon
//
//  Created by Marlon David Ruiz Arroyave on 9/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PokemonsBusinessLogic {
    func fetchPokemons(request: Pokemons.FetchPokemons.Request)
}

protocol PokemonsDataStore {
    var pokemons: [Pokemon]? { get }
}

class PokemonsInteractor: PokemonsBusinessLogic, PokemonsDataStore {
    var presenter: PokemonsPresentationLogic?
    var worker: PokemonsWorker?
    var pokemons: [Pokemon]?
    
    func fetchPokemons(request: Pokemons.FetchPokemons.Request) {
        worker = PokemonsWorker()

        worker?.fetchPokemons { [unowned self] result in
            let response = Pokemons.FetchPokemons.Response(result: result)
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
            default:
                break
            }
            self.presenter?.presentFetchedPokemons(response: response)
        }
    }
}
