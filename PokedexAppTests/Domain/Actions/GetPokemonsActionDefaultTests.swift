//
//  GetPokemonsActionDefaultTests.swift
//  PokedexAppTests
//
//  Created by Luis Chavez pozo on 4/12/24.
//

import XCTest
@testable import PokedexApp

final class GetPokemonsActionDefaultTests: XCTestCase {
    private var sut: GetPokemonsActionDefault!
    private var pokemonService: PokemonServiceSpy!
    private var pokemonRepository: PokemonRepositorySpy!
    private var pokemonsResults: [Pokemon]!

    func test_execute_serviceSuccess() async {
        givenSUT()
        givenPokemonsServiceSuccess()
        await whenExecute()
        XCTAssertFalse(pokemonsResults.isEmpty)
        XCTAssertTrue(pokemonService.invokedGetPokemons)
        XCTAssertTrue(pokemonRepository.invokedSavePokemons)
        
    }

    func test_execute_serviceFailure_withLocalPokemons() async {
        givenSUT()
        givenLocalPokemons(with: PokemonMother.randomPokemons())
        givenPokemonsServiceFailure()
        await whenExecute()
        XCTAssertFalse(pokemonsResults.isEmpty)
        XCTAssertFalse(pokemonRepository.invokedSavePokemons)
    }

    func test_execute_serviceFailure_andEmptyLocalPokemons() async {
        givenSUT()
        givenLocalPokemons(with: [])
        givenPokemonsServiceFailure()
        await whenExecute()
        XCTAssertTrue(pokemonsResults.isEmpty)
        XCTAssertFalse(pokemonRepository.invokedSavePokemons)
    }
}

private extension GetPokemonsActionDefaultTests {
    func givenSUT() {
        pokemonService = PokemonServiceSpy()
        pokemonRepository = PokemonRepositorySpy()
        let pokedexDataManager = PokedexDataManager(pokemonService: pokemonService)
        sut = GetPokemonsActionDefault(pokedexDataManager: pokedexDataManager,
                                       pokemonRepository: pokemonRepository)
    }

    func givenPokemonsServiceSuccess() {
        pokemonService.stubbedGetPokemonsResult = .success(PokemonMother.randomPokemons())
        pokemonService.stubbedGetPokemonDetailResult = .success(PokemonDetailMother.pokemonDetail())
        pokemonService.stubbedGetEvolutionChainResult = .success(EvolutionChainMother.evolutionChain())
    }

    func givenLocalPokemons(with pokemons: [Pokemon]) {
        pokemonRepository.stubbedGetPokemonsResult = pokemons
    }
    
    func givenPokemonsServiceFailure()  {
        let someError = NSError(domain: "", code: 0)
        pokemonService.stubbedGetPokemonsResult = .failure(someError)
    }

    func whenExecute() async {
        pokemonsResults = await sut.execute()
    }
}
