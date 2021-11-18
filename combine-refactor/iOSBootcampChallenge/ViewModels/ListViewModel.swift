//
//  ListViewModel.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import Foundation
import Combine

protocol ListViewModelDelegate: AnyObject {
    func didBeginRefresing()
    func didEndRefresing()
    func filterString() -> String?
}

class ListViewModel: NSObject {

    private var model: PokeModel
    private var pokemons: [Pokemon] = []

    private weak var delegate: ListViewModelDelegate?

    var cancelBag = Set<AnyCancellable>()

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

        model.getListOfPokemons(limit: 151)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                fatalError(error.localizedDescription)
            }, receiveValue: { [weak self] pokemons in
                self?.pokemons = pokemons
                self?.didRefresh()
            })
            .store(in: &cancelBag)
    }

    func didRefresh() {
        self.delegate?.didEndRefresing()
    }

}
