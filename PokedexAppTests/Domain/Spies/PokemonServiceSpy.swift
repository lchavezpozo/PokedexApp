//
//  PokemonServiceSpy.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
@testable import PokedexApp

class PokemonServiceSpy: PokemonService, @unchecked Sendable {
    var invokedGetPokemons = false
    var invokedGetPokemonsCount = 0
    var invokedGetPokemonsParameters: (limit: Int, offset: Int)?
    var invokedGetPokemonsParametersList = [(limit: Int, offset: Int)]()
    var stubbedGetPokemonsResult: Result<[Pokemon], Error>!

    func getPokemons(limit: Int, offset: Int) async -> Result<[Pokemon], Error> {
        invokedGetPokemons = true
        invokedGetPokemonsCount += 1
        invokedGetPokemonsParameters = (limit, offset)
        invokedGetPokemonsParametersList.append((limit, offset))
        return stubbedGetPokemonsResult
    }

    var invokedGetPokemonDetail = false
    var invokedGetPokemonDetailCount = 0
    var invokedGetPokemonDetailParameters: (pokemonId: Int, Void)?
    var invokedGetPokemonDetailParametersList = [(pokemonId: Int, Void)]()
    var stubbedGetPokemonDetailResult: Result<PokemonDetail, Error>!

    func getPokemonDetail(pokemonId: Int) async -> Result<PokemonDetail, Error> {
        invokedGetPokemonDetail = true
        invokedGetPokemonDetailCount += 1
        invokedGetPokemonDetailParameters = (pokemonId, ())
        invokedGetPokemonDetailParametersList.append((pokemonId, ()))
        return stubbedGetPokemonDetailResult
    }

    var invokedGetEvolutionChain = false
    var invokedGetEvolutionChainCount = 0
    var invokedGetEvolutionChainParameters: (pokemonId: Int, Void)?
    var invokedGetEvolutionChainParametersList = [(pokemonId: Int, Void)]()
    var stubbedGetEvolutionChainResult: Result<[Pokemon], Error>!

    func getEvolutionChain(pokemonId: Int) async -> Result<[Pokemon], Error> {
        invokedGetEvolutionChain = true
        invokedGetEvolutionChainCount += 1
        invokedGetEvolutionChainParameters = (pokemonId, ())
        invokedGetEvolutionChainParametersList.append((pokemonId, ()))
        return stubbedGetEvolutionChainResult
    }
}
