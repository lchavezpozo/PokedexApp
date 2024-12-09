//
//  PokemonEvolutionView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit
import SDWebImage

class PokemonEvolutionView : UIView {
    private let pokemon: Pokemon
        
    private let pokemonEvolutionStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let pokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.gray.withAlphaComponent(0.2)
        imageView.image = UIImage(named: "pokeball")?.withTintColor(color)
        return imageView
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_setImage(with: pokemon.imageUrl)
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemon.number
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemon.name
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(frame: .zero)
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PokemonEvolutionView {
    func setupUI() {
        setupPokeballImageView()
        setupPokemonEvolutionStackView()
    }
    
    func setupPokeballImageView() {
        addSubview(pokeballImage)
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            pokeballImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -9),
            pokeballImage.widthAnchor.constraint(equalToConstant: 100),
            pokeballImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupPokemonEvolutionStackView() {
        addSubview(pokemonEvolutionStackView)
        pokemonEvolutionStackView.addArrangedSubview(pokemonImage)
        NSLayoutConstraint.activate([
            pokemonImage.heightAnchor.constraint(equalToConstant: 80),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80)
        ])
        pokemonEvolutionStackView.addArrangedSubview(numberLabel)
        pokemonEvolutionStackView.setCustomSpacing(1, after: numberLabel)
        pokemonEvolutionStackView.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            pokemonEvolutionStackView.topAnchor.constraint(equalTo: topAnchor),
            pokemonEvolutionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonEvolutionStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -14),
            pokemonEvolutionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
