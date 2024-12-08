//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
import Foundation

final class Pokemon: Hashable, Sendable {
    let id: Int
    let name: String
    var number: String {
        ""
    }

    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork//\(id)/.png")
    }

    let detail: PokemonDetailStore = PokemonDetailStore()
    let evolutionChain: PokemonEvolutionChainStore = PokemonEvolutionChainStore()

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
        }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

actor PokemonDetailStore {
    private(set) var detail: PokemonDetail?

    func update(detail: PokemonDetail) {
        self.detail = detail
    }
}

actor PokemonEvolutionChainStore {
    private(set) var chain: [Pokemon] = []
    
    func update(chain: [Pokemon]) {
        self.chain = chain
    }
}
