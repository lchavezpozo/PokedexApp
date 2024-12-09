//
//  PokemonEvolutionChainView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit

class PokemonEvolutionChainView: UIView {
    private let pokemon: Pokemon
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Evolutions"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(frame: .zero)
        setupUI()
        Task {
            let evolutionChain = await pokemon.evolutionChain.chain
            let color = await pokemon.getColor()
            titleLabel.textColor = UIColor(hex: color)
            await setupEvulutionChain(evolutionChain: evolutionChain)
            if verticalStackView.arrangedSubviews.isEmpty {
                let label = UILabel()
                label.numberOfLines = 0
                label.text = "Este Pokémon no tiene evoluciones.\nMenos trabajo para ti. Este Pokémon ya está en su forma final. ¡Es único en su especie!"
                verticalStackView.addArrangedSubview(label)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupEvulutionChain(evolutionChain: PokemonEvolutionChain?) async {
        guard let evolutionChain, !evolutionChain.evolutions.isEmpty else { return }
        let currentPokemon = evolutionChain.pokemon
        for evolution in evolutionChain.evolutions {
            let evolutionGroup = PokemonEvolutionGroupView(pokemon: currentPokemon, evolutionTo: evolution.pokemon)
            verticalStackView.addArrangedSubview(evolutionGroup)
            await setupEvulutionChain(evolutionChain: evolution)
        }
    }
}

private extension PokemonEvolutionChainView {
    func setupUI() {
        setupTitleLabel()
        setupVerticalStackView()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setupVerticalStackView() {
        addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
