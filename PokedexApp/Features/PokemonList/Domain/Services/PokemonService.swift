//
//  PokemonService.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//

protocol PokemonService {
    func getPokemons()  async -> Result<[Pokemon], Error>
}
