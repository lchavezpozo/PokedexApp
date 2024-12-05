//
//  PokemonServiceSpy.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
@testable import PokedexApp

class PokemonServiceSpy: PokemonService {
    var invokedGetPokemons = false
    var invokedGetPokemonsCount = 0
    var stubbedGetPokemonsResult: Result<[Pokemon], Error>!

    func getPokemons() async -> Result<[Pokemon], Error> {
        invokedGetPokemons = true
        invokedGetPokemonsCount += 1
        return stubbedGetPokemonsResult
    }
}
