//
//  ss.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 9/12/24.
//

extension PokemonEntity: @unchecked Sendable {
    func toModel() async -> Pokemon {
        let types = (types)?
            .compactMap { $0 as? PokemonTypeEntity }
            .compactMap { $0.name } ?? []
        let detail = PokemonDetail(weight: Int(weight), height: Int(height), types: types)
        let pokemon = Pokemon(id: Int(id), name: name ?? "")
        await pokemon.detail.update(detail: detail)
        return pokemon
    }
}

extension PokemonTypeEntity: @unchecked Sendable {
    
}
