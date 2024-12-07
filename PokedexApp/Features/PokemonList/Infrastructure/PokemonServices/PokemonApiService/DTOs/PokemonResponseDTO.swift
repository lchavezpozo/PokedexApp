//
//  PokemonResponseDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//

struct PokemonResponseDTO: Decodable {
    let results: [PokemonDTO]

    func toModel() -> [Pokemon] {
        results.map { $0.toModel()}
    }
}
