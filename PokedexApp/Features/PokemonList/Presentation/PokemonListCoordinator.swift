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

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let pokemonApiService = PokemonApiService()
        let pokedexDataManager = PokedexDataManager(pokemonService: pokemonApiService)
        let repository = PokemonCoreDataRepository()
        let getPokemonsAction = GetPokemonsActionDefault(pokedexDataManager: pokedexDataManager,
                                                         pokemonRepository: repository)
        let viewModel = PokemonListViewModelDefault(getPokemonsAction: getPokemonsAction)
        window.rootViewController = UINavigationController(rootViewController: PokemonListViewController(viewModel: viewModel))
        window.makeKeyAndVisible()
    }
}
