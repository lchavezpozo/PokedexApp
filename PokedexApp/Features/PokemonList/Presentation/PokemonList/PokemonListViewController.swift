//
//  PokemonListViewController.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//

import UIKit

class PokemonListViewController: UIViewController {
    private var viewModel: PokemonListViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonCellView.self, forCellReuseIdentifier: PokemonCellView.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 127
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private lazy var dataSource: UITableViewDiffableDataSource<Int, Pokemon> = {
        UITableViewDiffableDataSource<Int, Pokemon>(tableView: tableView) { tableView, indexPath, pokemon in
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCellView.reuseIdentifier, for: indexPath) as? PokemonCellView
            cell?.configureCell(pokemon: pokemon)
            cell?.selectionStyle = .none
            return cell
        }
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupNavigationController()
        setupUI()
        fetchPokemons()
    }

    private func setupBinding() {
        viewModel.didLoadPokemon =  { [weak self] pokemon in
            self?.applySnapshot(pokemons: pokemon)
        }

        viewModel.didToggleEmptyStateView = { [weak self] isEmpty in
            self?.toggleEmptyStateView(isEmpty)
        }
    
        viewModel.didTogleLoadView = { [weak self] showLoading in
            self?.togleLoadingView(showLoading)
        }
    }

    private func setupNavigationController() {
        title = "Pokédex Kanto"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar aquí"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }

    private func fetchPokemons() {
        Task { await viewModel.fetchPokemonList() }
    }

    private func applySnapshot(pokemons: [Pokemon]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Pokemon>()
        snapshot.appendSections([0])
        snapshot.appendItems(pokemons)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func toggleEmptyStateView(_ shouldShow: Bool) {
        if shouldShow {
            let emptyView = SearchResultEmptyStateView()
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
    }

    private func togleLoadingView(_ shouldShow: Bool) {
        if shouldShow {
            loadingView.startLoading(parentView: view)
        } else {
            loadingView.stopLoading()
        }
    }
}

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
            viewModel.searchPokemon(query: searchText)
    }
}

private extension PokemonListViewController {
    func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
