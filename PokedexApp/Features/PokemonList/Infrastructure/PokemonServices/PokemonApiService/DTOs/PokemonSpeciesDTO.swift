//
//  PokemonSpeciesDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//

struct PokemonSpeciesDTO: Decodable {
    let evolutionChain: EvolutionChainURLDTO
}

struct EvolutionChainURLDTO: Decodable {
    let url: String
}
