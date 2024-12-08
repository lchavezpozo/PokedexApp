//
//  PokemonMother.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
@testable import PokedexApp

struct PokemonMother {
    static func pikachu() -> Pokemon {
        return Pokemon(
            id: 1,
            name: "Pikachu"
        )
    }
    
    static func bulbasaur() -> Pokemon {
        return Pokemon(
            id: 1,
            name: "Bulbasaur"
        )
    }
    
    static func charmander() -> Pokemon {
        return Pokemon(
            id: 1,
            name: "Charmander"
        )
    }
    
    static func charmeleon() -> Pokemon {
        return Pokemon(
            id: 1,
            name: "Charmeleon"
        )
    }
    
    static func randomPokemons() -> [Pokemon] {
        [PokemonMother.pikachu(),
         PokemonMother.bulbasaur(),
         PokemonMother.charmander()]
    }
}

struct PokemonDetailMother {
    static func pokemonDetail() -> PokemonDetail {
        return .init(weight: 100, height: 100, types: ["fire", "water"])
    }
}

struct EvolutionChainMother {
    static func evolutionChain() -> [Pokemon] {
        return  [PokemonMother.charmander(), PokemonMother.charmeleon()]
    }
}
