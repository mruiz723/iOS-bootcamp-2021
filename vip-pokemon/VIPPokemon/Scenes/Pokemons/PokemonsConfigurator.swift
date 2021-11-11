//
//  PokemonsConfigurator.swift
//  VIPPokemon
//
//  Created by Marlon David Ruiz Arroyave on 10/11/21.
//

import UIKit

struct PokemonsConfigurator {

    static func configureModule(viewController: PokemonsViewController) {
        let interactor = PokemonsInteractor()
        let presenter = PokemonsPresenter()
        let router = PokemonsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

}
