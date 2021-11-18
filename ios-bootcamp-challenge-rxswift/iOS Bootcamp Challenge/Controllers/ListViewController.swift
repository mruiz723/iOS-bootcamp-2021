//
//  ListViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit
import SVProgressHUD
import RxSwift

class ListViewController: UICollectionViewController, SearchBarDelegate {

    private var pokemons: [Pokemon] = []
    private var resultPokemons: [Pokemon] = []
    private let disposeBag: DisposeBag = DisposeBag()

    private var latestSearch: String? {
        UserDefaults.standard.string(forKey: .searchText)
    }

    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a pokemon", delegate: self)
        searchController.text = latestSearch
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()

    private var isFirstLauch: Bool = true

    private var shouldShowLoader: Bool = false {
        didSet {
            if shouldShowLoader {
                SVProgressHUD.shouldShowLoader(isFirstLauch)
            } else {
                isFirstLauch = false
                SVProgressHUD.shouldShowLoader(false)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        setupUI()
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

        refresh()
    }

    private func setupUI() {

        // Set up the collection view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white

        // Set up the refresh control as part of the collection view when it's pulled to refresh.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
    }

    // MARK: - UISearchViewController

    private func filterContentForSearchText(_ searchText: String) {
        // store latest search
        UserDefaults.standard.set(searchText, forKey: .searchText)
        // filter with a simple contains searched text
        resultPokemons = pokemons
            .filter {
                searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
            }
            .sorted {
                $0.id < $1.id
            }

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

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultPokemons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell
        else { preconditionFailure("Failed to load collection view cell") }
        cell.pokemon = resultPokemons[indexPath.item]
        return cell
    }

    // MARK: - Segue Management

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            fatalError()
        }

        if segue.identifier == DetailViewController.segueIdentifier {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                detailViewController.pokemon = resultPokemons[indexPath.row]
            }
        }
    }

    // MARK: - UI Hooks

    @objc func refresh() {
        shouldShowLoader = true

        PokeAPI().get(urlPath: "pokemon?limit=30")
            .subscribe { (pokemonList: PokemonList) in
                Observable<Pokemon>.zip(pokemonList.results.map { PokeAPI().get(urlPath: "/pokemon/\($0.id)/")})
                    .subscribe { pokemons in
                        print(pokemons)
                        self.pokemons = pokemons
                        self.didRefresh()
                    } onError: { error in
                        print("Error is: \(error.localizedDescription)")
                        self.didRefresh()
                    } onCompleted: {
                        print("OnCompleted")
                    } onDisposed: {
                        print("OnDisposed")
                    }
                    .disposed(by: self.disposeBag)

            } onError: { error in
                print("Error is: \(error.localizedDescription)")
                self.didRefresh()
            } onCompleted: {
                print("OnCompleted")
            } onDisposed: {
                print("OnDisposed")
            }.disposed(by: disposeBag)
    }

    private func didRefresh() {
        DispatchQueue.main.async {
            self.shouldShowLoader = false

            guard
                let collectionView = self.collectionView,
                let refreshControl = collectionView.refreshControl
            else { return }

            refreshControl.endRefreshing()

            self.updateSearchResults(for: self.searchController.text ??  "")
        }
    }

}
