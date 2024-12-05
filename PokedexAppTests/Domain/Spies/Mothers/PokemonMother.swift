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
            name: "Pikachu",
            number: 25,
            types: ["Electric"],
            imageUrl: "https://example.com/pikachu.png"
        )
    }
    
    static func bulbasaur() -> Pokemon {
        return Pokemon(
            name: "Bulbasaur",
            number: 1,
            types: ["Grass", "Poison"],
            imageUrl: "https://example.com/bulbasaur.png"
        )
    }
    
    static func charmander() -> Pokemon {
        return Pokemon(
            name: "Charmander",
            number: 4,
            types: ["Fire"],
            imageUrl: "https://example.com/charmander.png"
        )
    }
    
    static func randomPokemons() -> [Pokemon] {
        [PokemonMother.pikachu(),
         PokemonMother.bulbasaur(),
         PokemonMother.charmander()]
    }
}
