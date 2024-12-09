//
//  PokemonEvolutionGroupView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit

class PokemonEvolutionGroupView: UIView {
    private let pokemon: Pokemon
    private let evolutionTo: Pokemon

    init(pokemon: Pokemon, evolutionTo: Pokemon) {
        self.pokemon = pokemon
        self.evolutionTo = evolutionTo
        super.init(frame: .zero)
        setupUI()
    }
    
    private let pokemonEvolutionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    
    private lazy var currentPokemonView: PokemonEvolutionView = {
        let view = PokemonEvolutionView(pokemon: pokemon)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var evolutionToPokemonView: PokemonEvolutionView = {
        let view = PokemonEvolutionView(pokemon: evolutionTo)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let arrowEvolutionToImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .systemMint
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PokemonEvolutionGroupView {
    func setupUI() {
        setupPokemonEvolutionStackView()
    }

    func setupPokemonEvolutionStackView() {
        addSubview(pokemonEvolutionStackView)
        pokemonEvolutionStackView.addArrangedSubview(currentPokemonView)
        pokemonEvolutionStackView.addArrangedSubview(arrowEvolutionToImageView)
        pokemonEvolutionStackView.addArrangedSubview(evolutionToPokemonView)
        
        NSLayoutConstraint.activate([
            pokemonEvolutionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            pokemonEvolutionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pokemonEvolutionStackView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -10),
            pokemonEvolutionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
