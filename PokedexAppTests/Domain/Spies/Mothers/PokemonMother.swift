//
//  PokemonMother.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
@testable import PokedexApp

class PokemonMother {
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
    
    static func randomPokemons() -> [Pokemon] {
        [PokemonMother.pikachu(),
         PokemonMother.bulbasaur(),
         PokemonMother.charmander()]
    }
}
