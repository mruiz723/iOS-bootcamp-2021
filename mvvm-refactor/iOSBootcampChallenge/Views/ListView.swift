//
//  ListView.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import UIKit

struct ListView {

    let body: UICollectionView

    var viewModel: ListViewModel

    private let pokeList: PokeList

    init(viewModel: ListViewModel, body: UICollectionView) {
        self.viewModel = viewModel
        self.body = body
        self.pokeList = PokeList(viewModel: viewModel)
        self.viewLoad()
    }

    private func viewLoad() {
        // collection view layout set on storyboard

        // Set up the collection view.
        body.dataSource = pokeList
        body.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        body.backgroundColor = .white
        body.alwaysBounceVertical = true
        body.indicatorStyle = .white

        // Set up the refresh control as part of the collection view when it's pulled to refresh.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(viewModel, action: #selector(viewModel.refresh), for: .valueChanged)
        body.refreshControl = refreshControl
        body.sendSubviewToBack(refreshControl)

        viewModel.refresh()
    }

    class PokeList: NSObject, UICollectionViewDataSource {

        var viewModel: ListViewModel

        init(viewModel: ListViewModel) {
            self.viewModel = viewModel
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.numberOfPokeCells
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell
            else { preconditionFailure("Failed to load collection view cell") }
            cell.pokemon = viewModel.pokemon(at: indexPath.item)
            return cell
        }

    }
}
