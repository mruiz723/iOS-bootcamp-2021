//
//  DetailPokemonConfigurator.swift
//  VIPPokemon
//
//  Created by Marlon David Ruiz Arroyave on 10/11/21.
//

import UIKit

struct DetailPokemonConfigurator {

    static func configureModule(viewController: DetailPokemonViewController) {
        let interactor = DetailPokemonInteractor()
        let presenter = DetailPokemonPresenter()
        let router = DetailPokemonRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

}
