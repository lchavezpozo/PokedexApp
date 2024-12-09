//
//  PokemonTypeView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//

import UIKit

class PokemonTypeView: UIView {
    private let name: String
    private let color: UIColor

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name.capitalized
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

private extension PokemonTypeView {
    func setupUI() {
        setupStyle()
        setupNameLabel()
    }
    
    func setupStyle() {
        backgroundColor = color
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
