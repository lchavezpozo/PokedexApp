//
//  InfrastructureProvider.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 9/12/24.
//

struct InfrastructureProvider {
    @MainActor static func initializeCoreData() {
        _ = CoreDataStack.shared
    }

    static func getPokemonRepository() -> PokemonRepository {
        PokemonCoreDataRepository()
    }

    static func getPokemonService() -> PokemonService {
        PokemonApiService()
    }
}
 
