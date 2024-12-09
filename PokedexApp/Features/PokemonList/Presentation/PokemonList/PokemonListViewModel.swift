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
}

class PokemonListViewModelDefault: PokemonListViewModel {
    var didLoadPokemon: (([Pokemon]) -> Void)? = nil
    var didToggleEmptyStateView: ((Bool) -> Void)? = nil
    var didTogleLoadView: ((Bool) -> Void)? = nil

    private var pokemons: [Pokemon] = []
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
        didLoadPokemon?(pokemons)
    }

    func searchPokemon(query: String) {
        guard !query.isEmpty else {
            didToggleEmptyStateView?(false)
            didLoadPokemon?(pokemons)
            return
        }
        let pokemons = pokemons.filter { $0.name.lowercased().contains(query.lowercased())}
        let toggleEmptyStateView = pokemons.isEmpty
        didLoadPokemon?(pokemons)
        didToggleEmptyStateView?(toggleEmptyStateView)
    }

    func showPokemon(index: Int) {
        let pokemon = pokemons[index]
        onTapPokemon(pokemon)
    }
}
