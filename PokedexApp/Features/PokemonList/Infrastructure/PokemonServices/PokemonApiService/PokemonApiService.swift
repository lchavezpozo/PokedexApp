//
//  PokemonApiService.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//
import Foundation

fileprivate enum PokemonApi {
    case getPokemons(limit: Int, offset: Int)
    case getDetailPokemon(id: Int)
    case getSpecies(id: Int)

    var host: String { "https://pokeapi.co/api/" }
    var version: String { "v2" }

    var path: String {
        switch self {
        case .getPokemons(limit: let limit, offset: let offset):
            return  "pokemon?limit=\(limit)&offset=\(offset)"
        case .getDetailPokemon(id: let id):
            return "pokemon/\(id)"
        case .getSpecies(id: let id):
            return "pokemon-species/\(id)"
        }
    }

    var endpointURL: URL? { URL(string: host + version + "/" + path) }
}

struct PokemonApiService: PokemonService {
    private let session: URLSessionProtocol
        
    init(session: URLSessionProtocol = URLSession.shared) {
            self.session = session
    }

    func getPokemons(limit: Int, offset: Int) async -> Result<[Pokemon], Error> {
        do {
            let data = try await fetchData(from: PokemonApi.getPokemons(limit: limit, offset: offset).endpointURL)
            let decoder = JSONDecoder()
            let pokemonResponse = try decoder.decode(PokemonResponseDTO.self, from: data)
            return .success(pokemonResponse.toModel())
        } catch {
            return .failure(error)
        }
    }
    
    func getPokemonDetail(pokemonId: Int) async -> Result<PokemonDetail, Error> {
        do {
            let data = try await fetchData(from: PokemonApi.getDetailPokemon(id: pokemonId).endpointURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemonDetail = try decoder.decode(PokemonDetailDTO.self, from: data)
            return .success(pokemonDetail.toModel())
        } catch {
            return .failure(error)
        }
    }

    func getEvolutionChain(pokemonId: Int) async -> Result<PokemonEvolutionChain, Error> {
        do {
            let species = try await getSpecies(pokemonId: pokemonId)
            let data = try await fetchData(from: URL(string: species.evolutionChain.url))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemonEvolutionChain = try decoder.decode(EvolutionChainDTO.self, from: data)
            
            return .success(pokemonEvolutionChain.toModal())
        } catch {
            return .failure(error)
        }
    }
}

private extension PokemonApiService {
    func fetchData(from url: URL?) async throws -> Data {
        guard let url = url else {
            throw URLError(.badURL)
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }

    func getSpecies(pokemonId: Int) async throws -> PokemonSpeciesDTO {
        do {
            let data = try await fetchData(from: PokemonApi.getSpecies(id: pokemonId).endpointURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let species = try decoder.decode(PokemonSpeciesDTO.self, from: data)
            return species
        } catch {
            throw error
        }
    }
}
