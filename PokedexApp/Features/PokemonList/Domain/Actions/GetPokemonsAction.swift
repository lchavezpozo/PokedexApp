//
//  GetPokemonsAction.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
import OSLog

protocol GetPokemonsAction: Sendable {
    func execute() async -> [Pokemon]
}

struct GetPokemonsActionDefault: GetPokemonsAction {
    private let pokedexDataManager: PokedexDataManager
    private let pokemonRepository: PokemonRepository

    init(pokedexDataManager: PokedexDataManager, pokemonRepository: PokemonRepository) {
        self.pokedexDataManager = pokedexDataManager
        self.pokemonRepository = pokemonRepository
    }

    func execute() async -> [Pokemon] {
        let localPokemons = await pokemonRepository.getPokemons()
        do {
            let pokemons = try await pokedexDataManager.getCompleteInformation(numberOfPokemons: 151)
            await pokemonRepository.savePokemons(pokemons)
            return pokemons
        } catch {
            Logger().debug("Error getting pokemons: \(error)")
            return localPokemons
        }
    }
}
