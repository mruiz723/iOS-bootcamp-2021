//
//  ListViewModel.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didBeginRefresing()
    func didEndRefresing()
    func filterString() -> String?
}

class ListViewModel: NSObject {

    private let model: PokeModel
    private var pokemons: [Pokemon] = []

    private weak var delegate: ListViewModelDelegate?

    init(model: PokeModel, delegate: ListViewModelDelegate? = nil) {
        self.model = model
        self.delegate = delegate
    }

    private var resultPokemons: [Pokemon] {
        let filterString = self.delegate?.filterString() ?? ""
        return pokemons
            .filter {
                filterString.isEmpty || $0.name.lowercased().contains(filterString.lowercased())
            }
            .sorted {
                $0.id < $1.id
            }
    }

    var numberOfPokeCells: Int {
        resultPokemons.count
    }

    func pokemon(at index: Int) -> Pokemon {
        resultPokemons[index]
    }

    @objc func refresh() {
        delegate?.didBeginRefresing()

        model.getListOfPokemons(limit: 151, completion: { [weak self] pokemons in
            self?.pokemons = pokemons
            self?.didRefresh()
        })
    }

    func didRefresh() {
        self.delegate?.didEndRefresing()
    }

}
