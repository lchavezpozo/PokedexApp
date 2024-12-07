//
//  PokemonApiServiceTests.swift
//  PokedexAppTests
//
//  Created by Luis Chavez pozo on 6/12/24.
//

import XCTest
@testable import PokedexApp

final class PokemonApiServiceTests: XCTestCase {
    var sut: PokemonApiService!
    var urlSession: URLSessionSpy!
    
    func test_getPokemons_success() async {
        givenSUT()
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1&offset=0")!
        let data = makePokemonData()
        givenUrlSessionWith(url: expectedURL, data: data, statusCode: 200)
        
        let result = await sut.getPokemons(limit: 1, offset: 0)
        
        switch result {
        case .success(let pokemons):
            XCTAssertEqual(pokemons.count, 1)
            XCTAssertEqual(pokemons.first?.name, "bulbasaur")
            XCTAssertEqual(urlSession.invokedDataParameters?.url, expectedURL)
        case .failure(let error):
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    func test_getPokemons_failure() async {
        givenSUT()
        givenUrlSessionWithError()
        let result = await sut.getPokemons(limit: 1, offset: 0)
        
        switch result {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure:
            XCTAssertTrue(urlSession.invokedData)
            XCTAssertTrue(true)
        }
    }
    
    func test_getPokemonDetail_success() async {
        givenSUT()
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon/1")!
        let data = makePokemonDetailsData()
        givenUrlSessionWith(url: expectedURL, data: data, statusCode: 200)
        let result =  await sut.getPokemonDetail(pokemonId: 1)
        
        switch result {
        case .success(let pokemonDetail):
            XCTAssertEqual(pokemonDetail.height, 7)
            XCTAssertEqual(pokemonDetail.weight, 69)
            XCTAssertEqual(pokemonDetail.types, ["grass", "poison"])
            XCTAssertEqual(urlSession.invokedDataParameters?.url, expectedURL)
        case .failure(let error):
            XCTFail("Expected success, but got error: \(error)")
        }
    }
}

private extension  PokemonApiServiceTests {
    func givenSUT() {
        urlSession = URLSessionSpy()
        sut = PokemonApiService(session: urlSession)
    }
    
    func givenUrlSessionWith(url: URL, data: Data, statusCode: Int) {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        urlSession.stubbedDataResult = (data, response)
    }
    
    func givenUrlSessionWithError() {
        urlSession.stubbedDataError = URLError(.notConnectedToInternet)
    }
    
    func makePokemonData() -> Data {
        return """
        {
            "results": [
                { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/" }
            ]
        }
        """.data(using: .utf8)!
    }
    
    func makePokemonDetailsData() -> Data {
        return """
        {
            "id": 1,
            "name": "bulbasaur",
            "height": 7,
            "weight": 69,
            "types": [
                { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } },
                { "slot": 2, "type": { "name": "poison", "url": "https://pokeapi.co/api/v2/type/4/" } }
            ]
        }
        """.data(using: .utf8)!
    }
}
