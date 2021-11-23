//
//  ListViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class ListViewController: UICollectionViewController {

    var viewModel: ListViewModel?
    var listView: ListView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let model       = PokeModel(api: PokeAPI.shared)
        let viewModel   = ListViewModel(model: model, delegate: self)
        let listView    = ListView(viewModel: viewModel, body: collectionView)

        self.viewModel = viewModel
        self.listView = listView

        setup()
    }

    // MARK: Setup

    private func setup() {
        title = "Pokédex"

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .black
        navbar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navbar.prefersLargeTitles = true

        // Set up the searchController parameters.
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: Components

    private var latestSearch: String? {
        get {
            UserDefaults.standard.string(forKey: .searchText)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .searchText)
        }
    }

    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a pokemon", delegate: self)
        searchController.text = latestSearch
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()

    lazy private var activityIndicator = LaunchActivityIndicator(superview: view)

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == DetailViewController.segueIdentifier,
            let detailViewController = segue.destination as? DetailViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let pokemon = viewModel?.pokemon(at: indexPath.row)
        else {
            return
        }

        detailViewController.pokemon = pokemon
    }

}

extension ListViewController: SearchBarDelegate {

    // MARK: - UISearchViewController

    private func filterContentForSearchText(_ searchText: String) {
        // store latest search
        latestSearch = searchText

        collectionView.reloadData()
    }

    func updateSearchResults(for text: String) {
        filterContentForSearchText(text)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
    }

}

extension ListViewController: ListViewModelDelegate {

    func filterString() -> String? {
        latestSearch
    }

    func didBeginRefresing() {
        activityIndicator.shouldShowLoader = true
    }

    func didEndRefresing() {
        activityIndicator.shouldShowLoader = false

        collectionView?.refreshControl?.endRefreshing()

        collectionView.reloadData()
    }

}
