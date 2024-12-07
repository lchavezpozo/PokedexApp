//
//  GetPokemonsAction.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
import OSLog

enum GetPokemonsActionError: Error {
    case emptyPokemons
}

protocol GetPokemonsAction {
    func execute() async -> [Pokemon]
}

struct GetPokemonsActionDefault: GetPokemonsAction {
    private let pokemonService: PokemonService
    private let pokemonRepository: PokemonRepository

    init(pokemonService: PokemonService, pokemonRepository: PokemonRepository) {
        self.pokemonService = pokemonService
        self.pokemonRepository = pokemonRepository
    }

    func execute() async -> [Pokemon] {
        let localPokemons = await pokemonRepository.getPokemons()
        let result = await pokemonService.getPokemons(limit: 151, offset: 0)
        switch result {
            case .success(let pokemons):
            await pokemonRepository.savePokemons(pokemons)
            return pokemons
        case .failure(let error):
            Logger().debug("Error getting pokemons: \(error)")
            return localPokemons
        }
    }
}
