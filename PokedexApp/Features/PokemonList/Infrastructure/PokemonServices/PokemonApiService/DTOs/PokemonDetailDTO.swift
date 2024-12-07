//
//  PokemonDetailDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//
import Foundation

struct PokemonDetailDTO: Decodable {
    let weight: Int
    let height: Int
    let types: [PokemonTypeDTO]

    func toModel() -> PokemonDetail {
        let types = types.map(\.type.name)
        return PokemonDetail(weight: weight,
                             height: height,
                             types: types)
        
    }
}

struct PokemonTypeDTO: Decodable {
    let type: PokemonTypeValueDTO
}

struct PokemonTypeValueDTO: Decodable {
    let name: String
    let url: URL
}
