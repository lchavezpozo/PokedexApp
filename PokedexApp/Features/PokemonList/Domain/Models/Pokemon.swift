//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
import Foundation

struct Pokemon {
    let id: Int
    let name: String
    var number: String {
        ""
    }
    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork//\(id)/.png")
    }
}
