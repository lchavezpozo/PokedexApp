//
//  EvolutionChainDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//

struct EvolutionChainDTO: Decodable {
    let chain: EvolutionNodeDTO

    func toModal() -> PokemonEvolutionChain {
        chain.toModel()
    }
}

struct EvolutionNodeDTO: Decodable {
    let pokemon: PokemonDTO
    let evolvesTo: [EvolutionNodeDTO]

    enum CodingKeys: String, CodingKey {
        case pokemon = "species"
        case evolvesTo
    }
    
    func toModel() -> PokemonEvolutionChain {
        let pokemon = pokemon.toModel()
        let evolutionChain = evolvesTo.map { $0.toModel()}
        return PokemonEvolutionChain(pokemon: pokemon, evolutions: evolutionChain)
    }
}
