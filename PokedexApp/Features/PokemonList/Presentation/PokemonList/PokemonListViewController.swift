//
//  PokemonListViewController.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//

import UIKit

class PokemonListViewController: UIViewController {
    var pokemonService: PokemonApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red

        Task {
            pokemonService = PokemonApiService()
            let resut = await pokemonService?.getEvolutionChain(pokemonId: 25)
            switch resut {
            case .success(let pokemons):
                print(pokemons)
            case .failure(let error):
                print(error)
            case .none:
                print( "No pokemons")
            }
        }
    }
}
