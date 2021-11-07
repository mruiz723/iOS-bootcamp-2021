//
//  DetailViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    static let segueIdentifier = "goDetailViewControllerSegue"

    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            let viewModel = DetailViewModel(pokemon: pokemon)
            self.detailView = DetailView(viewModel: viewModel, container: view, delegate: self)
        }
    }

    var detailView: DetailView? {
        didSet {
            guard let view = oldValue else { return }
            view.body.removeFromSuperview()
        }
    }

}

extension DetailViewController: DetailViewDelegate {

    func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

}
