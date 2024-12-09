//
//  PokemonInformationView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit

class PokemonInformationView: UIView {
    private let pokemonInformationStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupPokemonInformationStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView(weight: Int, height: Int, color: UIColor?) {
        heightLabel.text = "Altura: \(Double(height) / 10) m"
        weightLabel.text = "Peso: \(Double(weight) / 10) kg"
        if let color {
            titleLabel.textColor = color
        }
    }
}

private extension PokemonInformationView {
    func setupUI(){
        setupPokemonInformationStackView()
    }

    func setupPokemonInformationStackView() {
        addSubview(pokemonInformationStackView)
        pokemonInformationStackView.addArrangedSubview(titleLabel)
        pokemonInformationStackView.setCustomSpacing(10, after: titleLabel)
        pokemonInformationStackView.addArrangedSubview(heightLabel)
        pokemonInformationStackView.addArrangedSubview(weightLabel)
        NSLayoutConstraint.activate([
            pokemonInformationStackView.topAnchor.constraint(equalTo: topAnchor),
            pokemonInformationStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                 constant: 20),
            pokemonInformationStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            pokemonInformationStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
