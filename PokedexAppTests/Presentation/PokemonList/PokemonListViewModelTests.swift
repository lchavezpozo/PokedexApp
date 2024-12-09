//
//  PokemonListViewModelTests.swift
//  PokedexAppTests
//
//  Created by Luis Chavez pozo on 8/12/24.
//

import XCTest
@testable import PokedexApp

@MainActor
final class PokemonListViewModelTests: XCTestCase {
    private var sut: PokemonListViewModelDefault!
    private var getPokemonsAction: GetPokemonActionSpy!
    private var didLoadPokemonCalled: [[Pokemon]] = []
    private var didToggleEmptyStateViewCalled: [Bool] = []
    private var didToggleLoadViewCalled: [Bool] = []

    func test_FetchPokemonList_Successfully() async {
        givenSut()
        let pokemons = [PokemonMother.bulbasaur(),
                        PokemonMother.charmander()]
        givenGetPokemonsActionResult(pokemons)
        await whenFetchPokemonList()
        XCTAssertEqual(didToggleLoadViewCalled, [true, false])
        XCTAssertEqual(didLoadPokemonCalled.first, pokemons)
    }

    func test_SearchPokemon_FoundResults() async {
        givenSut()
        let pokemons = [PokemonMother.bulbasaur(),
                        PokemonMother.charmander()]
        givenGetPokemonsActionResult(pokemons)
        await whenFetchPokemonList()
        whenSearchPokemon("bulb")
        XCTAssertEqual(didLoadPokemonCalled.last?.count, 1)
        XCTAssertEqual(didLoadPokemonCalled.last?.first?.name, "Bulbasaur")
        XCTAssertEqual(didToggleEmptyStateViewCalled.last, false)
    }

    func test_SearchPokemon_NoResults() async {
        givenSut()
        let pokemons = [PokemonMother.bulbasaur(),
                        PokemonMother.charmander()]
        givenGetPokemonsActionResult(pokemons)
        await whenFetchPokemonList()
        whenSearchPokemon("Pikachu")
        XCTAssertEqual(didLoadPokemonCalled.last?.count, 0)
        XCTAssertEqual(didToggleEmptyStateViewCalled.last, true)
    }

    func test_SearchPokemon_EmptyQuery() async {
        givenSut()
        let pokemons = [PokemonMother.bulbasaur(),
                        PokemonMother.charmander()]
        givenGetPokemonsActionResult(pokemons)
        await whenFetchPokemonList()
        whenSearchPokemon("")
        XCTAssertEqual(didLoadPokemonCalled.last, pokemons)
        XCTAssertEqual(didToggleEmptyStateViewCalled.last, false)
    }
}

private extension PokemonListViewModelTests {
    func givenSut() {
        getPokemonsAction = GetPokemonActionSpy()
        sut = PokemonListViewModelDefault(getPokemonsAction: getPokemonsAction)

        sut.didLoadPokemon = { [weak self] pokemons in
            self?.didLoadPokemonCalled.append(pokemons)
        }
        sut.didToggleEmptyStateView = { [weak self] isEmpty in
            self?.didToggleEmptyStateViewCalled.append(isEmpty)
        }
        sut.didTogleLoadView = { [weak self] isLoading in
            self?.didToggleLoadViewCalled.append(isLoading)
        }
    }

    func givenGetPokemonsActionResult(_ result: [Pokemon]) {
        getPokemonsAction.stubbedExecuteResult = result
    }

    func whenFetchPokemonList() async {
        await sut.fetchPokemonList()
    }

    func whenSearchPokemon(_ searchText: String) {
        sut.searchPokemon(query: searchText)
    }
}
