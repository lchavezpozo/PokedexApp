//
//  PokemonListViewModel.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//

@MainActor
protocol PokemonListViewModel {
    func fetchPokemonList() async
    func searchPokemon(query: String)
    func showPokemon(index: Int)
    
    var didLoadPokemon: (([Pokemon]) -> Void)? { get set }
    var didToggleEmptyStateView: ((Bool) -> Void)? { get set }
    var didTogleLoadView: ((Bool) -> Void)? { get set }
    var didEmptyResult: (()->Void)? { get set }
}

class PokemonListViewModelDefault: PokemonListViewModel {
    var didLoadPokemon: (([Pokemon]) -> Void)? = nil
    var didToggleEmptyStateView: ((Bool) -> Void)? = nil
    var didTogleLoadView: ((Bool) -> Void)? = nil
    var didEmptyResult: (()->Void)? = nil

    private var pokemons: [Pokemon] = []
    private var originalPokemons: [Pokemon] = []

    private let getPokemonsAction: GetPokemonsAction
    private let onTapPokemon: ((Pokemon) -> Void)

    init(getPokemonsAction: GetPokemonsAction,
         onTapPokemon: @escaping ((Pokemon) -> Void)) {
        self.getPokemonsAction = getPokemonsAction
        self.onTapPokemon = onTapPokemon
    }

    func fetchPokemonList() async {
        didTogleLoadView?(true)
        pokemons = await getPokemonsAction.execute()
        didTogleLoadView?(false)
        if pokemons.isEmpty {
            didEmptyResult?()
        } else {
            didLoadPokemon?(pokemons)
            originalPokemons = pokemons
        }
    }

    func searchPokemon(query: String) {
        if query.isEmpty {
            pokemons = originalPokemons
            didToggleEmptyStateView?(false)
        } else {
            let filteredPokemons = originalPokemons
                .filter { $0.name.lowercased().contains(query.lowercased()) }
            pokemons = filteredPokemons
            didToggleEmptyStateView?(filteredPokemons.isEmpty)
        }
        didLoadPokemon?(pokemons)
    }

    func showPokemon(index: Int) {
        guard index >= 0 && index < pokemons.count else { return }
        let pokemon = pokemons[index]
        onTapPokemon(pokemon)
    }
}
