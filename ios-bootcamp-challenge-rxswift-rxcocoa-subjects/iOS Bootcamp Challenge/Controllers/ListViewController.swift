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
        tableViewModelSelected()
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

    // MARK: - UI Hooks

    @objc func refresh() {
//        shouldShowLoader = true

        PokeAPI().get(urlPath: "pokemon?limit=30")
            .subscribe { [unowned self] (pokemonList: PokemonList) in
                Observable<Pokemon>.zip(pokemonList.results.map { PokeAPI().get(urlPath: "/pokemon/\($0.id)/")})
                    .bind(to: self.collectionView
                            .rx
                            .items(cellIdentifier: PokeCell.identifier, cellType: PokeCell.self)) { index, item, cell in
                        cell.pokemon = item
                        print(index)
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

    private func tableViewModelSelected() {
        collectionView
            .rx
            .modelSelected(Pokemon.self)
            .subscribe(onNext: { [unowned self] pokemon in
                guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                    return
                }
                detailVC.pokemon = pokemon
                self.present(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
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
