//
//  PokedexDataManager.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 7/12/24.
//
import OSLog

actor PokedexDataManager {
    private var pokemons: [Pokemon] = []
    private let pokemonService: PokemonService

    init(pokemonService: PokemonService) {
        self.pokemonService = pokemonService
    }

    func getCompleteInformation(numberOfPokemons: Int) async throws -> [Pokemon] {
        pokemons = try await getPokemons(numberOfPokemons: numberOfPokemons)
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            for pokemon in pokemons {
                group.addTask {
                    try await self.getDetail(for: pokemon)
                    try await self.getEvolutionChain(for: pokemon)
                }
            }
            try await group.waitForAll()
        }
        return pokemons
    }

    private func getPokemons(numberOfPokemons: Int) async throws -> [Pokemon] {
        let result = await pokemonService.getPokemons(limit: numberOfPokemons, offset: 0)
        switch result {
        case .success(let pokemons):
            return pokemons
        case .failure(let error):
            Logger().debug("Error getting pokemons: \(error)")
            throw error
        }
    }

    nonisolated private func getDetail(for pokemon: Pokemon) async throws {
        let result = await pokemonService.getPokemonDetail(pokemonId: pokemon.id)
        switch result {
        case .success(let pokemonDetail):
            await pokemon.detail.update(detail: pokemonDetail)
        case .failure(let error):
            Logger().debug("Error getting pokemon detail: \(error)")
            throw error
        }
    }

    nonisolated private func getEvolutionChain(for pokemon: Pokemon) async throws {
        let result = await pokemonService.getEvolutionChain(pokemonId: pokemon.id)
        switch result {
        case .success(let evolutionChain):
            await pokemon.evolutionChain.update(chain: evolutionChain)
        case .failure(let error):
            Logger().debug("Error getting pokemon evolution chain: \(error)")
            throw error
        }
    }
}
