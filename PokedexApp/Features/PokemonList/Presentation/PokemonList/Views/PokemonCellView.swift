//
//  PokemonCellView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//

import UIKit
import SDWebImage

class PokemonCellView: UITableViewCell {
    static let reuseIdentifier = "PokemonCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 8
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
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var pokeballImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var pokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.white.withAlphaComponent(0.4)
        imageView.image = .pokeball.withTintColor(color)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(pokemon: Pokemon) {
        numberLabel.text = pokemon.number
        nameLabel.text = pokemon.name.capitalized
        pokemonImage.sd_setImage(with: pokemon.imageUrl)
        Task {
            await applyBackogrundColor(pokemon: pokemon)
            await addTypes(pokemon: pokemon)
        }
    }
    
    @MainActor
    private func applyBackogrundColor(pokemon: Pokemon) async {
        let colorHex = await pokemon.getColor()
        containerView.backgroundColor = UIColor(hex: colorHex)
    }
    
    @MainActor
    private func addTypes(pokemon: Pokemon) async {
        let types = await pokemon.detail.detail?.types ?? []
        types.forEach { type in
            let color = pokemon.getColorByType(type: type)
            let uiColor = UIColor(hex: color).darken(by: 0.1)
            let pokemonTypeView = PokemonTypeView(name: type, color: uiColor)
            pokemonTypeStackView.addArrangedSubview(pokemonTypeView)
        }
        contentView.layoutIfNeeded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonTypeStackView.arrangedSubviews.forEach { view in
            pokemonTypeStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

private extension PokemonCellView {
    func setupUI() {
        contentView.layer.cornerRadius = 15
        setupAddSubView()
        setupConstraints()
    }
    
    func setupAddSubView() {
        contentView.addSubview(containerView)
        containerView.addSubview(pokemonImage)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(numberLabel)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(pokemonTypeContainerView)
        pokemonTypeContainerView.addSubview(pokemonTypeStackView)
        containerView.addSubview(pokeballImageContainer)
        pokeballImageContainer.addSubview(pokeballImage)
        containerView.bringSubviewToFront(pokemonImage)
    }
    
    func setupConstraints() {
        setupContainerView()
        setupConstraintsMainStackView()
        setupPokemonTypeStackView()
        setupConstraintsPokemonImageView()
        setupConstraintPokeballImageContainer()
        setupConstraintsPokeballImageView()
    }
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupConstraintsMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: pokemonImage.leadingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18)
        ])

    }
    
    func setupPokemonTypeStackView() {
        NSLayoutConstraint.activate([
            pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonTypeContainerView.topAnchor),
            pokemonTypeStackView.leadingAnchor.constraint(equalTo: pokemonTypeContainerView.leadingAnchor),
            pokemonTypeStackView.trailingAnchor.constraint(lessThanOrEqualTo: pokemonTypeContainerView.trailingAnchor),
            pokemonTypeStackView.bottomAnchor.constraint(equalTo: pokemonTypeContainerView.bottomAnchor),
            pokemonTypeStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }
    
    func setupConstraintPokeballImageContainer(){
        NSLayoutConstraint.activate([
            pokeballImageContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            pokeballImageContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pokeballImageContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

    }
    
    func setupConstraintsPokeballImageView(){
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: pokeballImageContainer.topAnchor),
            pokeballImage.leadingAnchor.constraint(equalTo: pokeballImageContainer.leadingAnchor),
            pokeballImage.trailingAnchor.constraint(equalTo: pokeballImageContainer.trailingAnchor, constant: 10),
            pokeballImage.bottomAnchor.constraint(equalTo: pokeballImageContainer.bottomAnchor)
        ])
    }

    func setupConstraintsPokemonImageView(){
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -15),
            pokemonImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            pokemonImage.widthAnchor.constraint(equalToConstant: 120),
            pokemonImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
