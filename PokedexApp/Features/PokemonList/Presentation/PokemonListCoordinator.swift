//
//  PokemonListCoordinator.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit

@MainActor
class PokemonListCoordinator {
    private let window: UIWindow

    private var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let pokemonApiService = InfrastructureProvider.getPokemonService()
        let pokedexDataManager = PokedexDataManager(pokemonService: pokemonApiService)
        let repository = InfrastructureProvider.getPokemonRepository()
        let getPokemonsAction = GetPokemonsActionDefault(pokedexDataManager: pokedexDataManager,
                                                         pokemonRepository: repository)
        let viewModel = PokemonListViewModelDefault(getPokemonsAction: getPokemonsAction, onTapPokemon: showPokemonDetail)
        window.rootViewController = UINavigationController(rootViewController: PokemonListViewController(viewModel: viewModel))
        window.makeKeyAndVisible()
    }

    func showPokemonDetail(pokemon: Pokemon) {
        let vc = PokemonDetailViewController(pokemon: pokemon)
        navigationController?.pushViewController(vc, animated: true)
    }
}
