//
//  PokemonCoreDataRepository.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import CoreData

final class PokemonCoreDataRepository: PokemonRepository {
    @MainActor
    func savePokemons(_ pokemons: [Pokemon]) async {
        do {
            try await CoreDataStack.shared.clearAllData()
            
            for pokemon in pokemons {
                try await savePokemon(pokemon)
            }

            try await CoreDataStack.shared.saveContext()
        } catch {
            print("Error al guardar los Pokémon: \(error)")
        }
    }

    @MainActor
    func getPokemons() async -> [Pokemon] {
        do {
            let pokemonEntities = try await CoreDataStack.shared.fetch(PokemonEntity.self)
            let pokemons = await pokemonEntities.asyncMap { await $0.toModel() }
            return pokemons.sorted(by: { $0.id < $1.id })
        } catch {
            print("Error al recuperar los Pokémon: \(error)")
            return []
        }
    }
}

private extension PokemonCoreDataRepository {
    @MainActor
    func savePokemon(_ pokemon: Pokemon) async throws {
        let pokemonEntity = CoreDataStack.shared.insert(PokemonEntity.self)
        pokemonEntity.id = Int16(pokemon.id)
        pokemonEntity.name = pokemon.name

        let detail = await pokemon.detail.detail
        pokemonEntity.weight = Int16(detail?.weight ?? 0)
        pokemonEntity.height = Int16(detail?.height ?? 0)

        if let types = detail?.types {
            for type in types {
                let typeEntity = try await fetchOrCreateType(named: type)
                pokemonEntity.addToTypes(typeEntity)
                typeEntity.addToPokemons(pokemonEntity)
            }
        }
    }

    @MainActor
    func fetchOrCreateType(named typeName: String) async throws -> PokemonTypeEntity {
        if let existingType = try await CoreDataStack.shared.fetch(PokemonTypeEntity.self, predicate: NSPredicate(format: "name == %@", typeName)).first {
            return existingType
        }

        let newTypeEntity =  CoreDataStack.shared.insert(PokemonTypeEntity.self)
        newTypeEntity.name = typeName
        return newTypeEntity
    }
}
