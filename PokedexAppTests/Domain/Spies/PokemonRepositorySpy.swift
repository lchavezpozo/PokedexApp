//
//  PokemonRepositorySpy.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
@testable import PokedexApp

class PokemonRepositorySpy: PokemonRepository {
    var invokedSavePokemons = false
    var invokedSavePokemonsCount = 0
    var invokedSavePokemonsParameters: (pokemons: [Pokemon], Void)?
    var invokedSavePokemonsParametersList = [(pokemons: [Pokemon], Void)]()

    func savePokemons(_ pokemons: [Pokemon]) async {
        invokedSavePokemons = true
        invokedSavePokemonsCount += 1
        invokedSavePokemonsParameters = (pokemons, ())
        invokedSavePokemonsParametersList.append((pokemons, ()))
    }

    var invokedGetPokemons = false
    var invokedGetPokemonsCount = 0
    var stubbedGetPokemonsResult: [Pokemon]! = []

    func getPokemons() async -> [Pokemon]  {
        invokedGetPokemons = true
        invokedGetPokemonsCount += 1
        return stubbedGetPokemonsResult
    }
}
