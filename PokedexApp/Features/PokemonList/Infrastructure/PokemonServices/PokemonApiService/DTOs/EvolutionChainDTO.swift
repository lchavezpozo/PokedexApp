//
//  EvolutionChainDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//

struct EvolutionChainDTO: Decodable {
    let chain: EvolutionNodeDTO
}

struct EvolutionNodeDTO: Decodable {
    let pokemon: PokemonDTO
    let evolvesTo: [EvolutionNodeDTO]

    enum CodingKeys: String, CodingKey {
        case pokemon = "species"
        case evolvesTo
    }
}
