//
//  PokemonService.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//

protocol PokemonService: Sendable {
    func getPokemons(limit: Int, offset: Int) async -> Result<[Pokemon], Error>
    func getPokemonDetail(pokemonId: Int) async -> Result<PokemonDetail, Error>
    func getEvolutionChain(pokemonId: Int) async -> Result<[Pokemon], Error>
}
