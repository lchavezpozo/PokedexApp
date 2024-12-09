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
        String(format: "#%03d", id)
    }

    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork//\(id).png")
    }

    let detail: PokemonDetailStore = PokemonDetailStore()
    let evolutionChain: PokemonEvolutionChainStore = PokemonEvolutionChainStore()

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    func getColor() async -> String {
        let pokemonColor = GetPokemonColorByType()
        let type = await detail.detail?.types.first ?? ""
        let color = pokemonColor.getColor(type: type)
        return color
    }
    
    func getColorByType(type: String) -> String {
        let pokemonColor = GetPokemonColorByType()
        return pokemonColor.getColor(type: type)
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
        }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

fileprivate struct  GetPokemonColorByType {
    func getColor(type: String) -> String {
        switch type {
        case "bug":
          return "#8BD674"
        case "dark":
          return "#6F6E78"
        case "dragon":
          return "#7383B9"
        case "electric":
          return "#ffd86f"
        case "fairy":
          return "#EBA8C3"
        case "fighting":
          return "#EB4971"
        case "fire":
          return "#fb6c6c"
        case "flying":
          return "#83A2E3"
        case "ghost":
          return "#8571BE"
        case "grass":
          return "#48d0b0"
        case "ground":
          return "#F78551"
        case "ice":
          return "#91D8DF"
        case "normal":
          return "#B5B9C4"
        case "poison":
          return "#9F6E97"
        case "psychic":
          return "#FF6568"
        case "rock":
          return "#D4C294"
        case "steel":
          return "#4C91B2"
        case "water":
          return "#76bdfe"
        default:
          return "F000"
        }
    }
}

actor PokemonDetailStore {
    private(set) var detail: PokemonDetail?

    func update(detail: PokemonDetail) {
        self.detail = detail
    }
}

actor PokemonEvolutionChainStore {
    private(set) var chain: PokemonEvolutionChain?

    func update(chain: PokemonEvolutionChain?) {
        self.chain = chain
    }
}

struct PokemonEvolutionChain {
    let pokemon: Pokemon
    let evolutions: [PokemonEvolutionChain]
}
