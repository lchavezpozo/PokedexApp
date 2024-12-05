//
//  PokemonRepository.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//


protocol PokemonRepository {
    func savePokemons(_ pokemons: [Pokemon]) async
    func getPokemons() async -> [Pokemon]
}
