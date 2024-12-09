//
//  PokemonDetailHeaderView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//

import UIKit

class PokemonDetailHeaderView: UIView {
        private let pokemon: Pokemon

        private let mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.distribution = .fill
            stackView.alignment = .fill
            return stackView
        }()
        
        private let pokemonTypeContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private let pokemonTypeStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.layer.cornerRadius = 8
            return stackView
        }()
        
        private lazy var numberLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = pokemon.number
            label.numberOfLines = 1
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: 12)
            return label
        }()
        
        private lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = pokemon.name.capitalized
            label.numberOfLines = 1
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        
        private let pokeballImageContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private let pokeballImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let color = UIColor.white.withAlphaComponent(0.4)
            imageView.image = .pokeball.withTintColor(color)
            return imageView
        }()
        
        private lazy var pokemonImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.sd_setImage(with: pokemon.imageUrl)
            imageView.tintColor = .white
            return imageView
        }()

        init(pokemon: Pokemon) {
            self.pokemon = pokemon
            super.init(frame: .zero)
            setupUI()
            Task {
                await addTypes()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implement")
        }

        @MainActor
        private func addTypes() async {
            let types = await pokemon.detail.detail?.types ?? []
            types.forEach { type in
                let color = pokemon.getColorByType(type: type)
                let uiColor = UIColor(hex: color).darken(by: 0.1)
                let pokemonTypeView = PokemonTypeView(name: type, color: uiColor)
                pokemonTypeStackView.addArrangedSubview(pokemonTypeView)
            }
        }
    }

private extension PokemonDetailHeaderView {
    func setupUI(){
        setupAddSubView()
        setupConstraints()
    }

    func setupAddSubView() {
        addSubview(pokeballImage)
        addSubview(pokemonImage)
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(numberLabel)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(pokemonTypeContainerView)
        pokemonTypeContainerView.addSubview(pokemonTypeStackView)
    }

    func setupConstraints() {
        setupConstraintsMainStackView()
        setupConstraintsPokeballImageView()
        setupConstraintsPokemonImageView()
        setupPokemonTypeStackView()
    }
    
    func setupConstraintsMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: pokeballImage.topAnchor,constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: pokeballImage.trailingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35)
        ])
        
    }

    func setupConstraintsPokeballImageView(){
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            pokeballImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            
            pokeballImage.widthAnchor.constraint(equalToConstant: 100),
            pokeballImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupConstraintsPokemonImageView(){
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: topAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pokemonImage.widthAnchor.constraint(equalToConstant: 120),
            pokemonImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func setupPokemonTypeStackView() {
        NSLayoutConstraint.activate([
            pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonTypeContainerView.topAnchor),
            pokemonTypeStackView.leadingAnchor.constraint(equalTo: pokemonTypeContainerView.leadingAnchor),
            pokemonTypeStackView.trailingAnchor.constraint(lessThanOrEqualTo: pokemonTypeContainerView.trailingAnchor),
            pokemonTypeStackView.bottomAnchor.constraint(equalTo: pokemonTypeContainerView.bottomAnchor)
        ])
    }
}
