//
//  GetPokemonActionSpy.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
@testable import PokedexApp

@MainActor
class GetPokemonActionSpy: GetPokemonsAction {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteResult: [Pokemon]! = []

    func execute() async -> [Pokemon] {
        invokedExecute = true
        invokedExecuteCount += 1
        return stubbedExecuteResult
    }
}
