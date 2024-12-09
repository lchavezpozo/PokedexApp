//
//  PokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//
import UIKit

class PokemonDetailViewController: UIViewController {
    private let pokemon: Pokemon

    private lazy var pokemonDetailHeaderView : PokemonDetailHeaderView = {
        let view = PokemonDetailHeaderView(pokemon: pokemon)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backgroundContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let pokemonInformationView: PokemonInformationView = {
        let view = PokemonInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pokemonEvolutionChainView: PokemonEvolutionChainView = {
        let view = PokemonEvolutionChainView(pokemon: pokemon)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await setupAsync()
        }
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupAsync() async {
        let color = await pokemon.getColor()
        view.backgroundColor = UIColor(hex: color)
        if let detail = await pokemon.detail.detail {
            pokemonInformationView.configureView(weight: detail.weight,
                                                 height: detail.height,
                                                 color: view.backgroundColor)
        }
    }
}

private extension PokemonDetailViewController {
    func setupUI() {
        setupPokemonDetailHeaderView()
        setupBackgroundContainerView()
        setupScollView()
        setupScrollViewContainer()
    }

    func setupPokemonDetailHeaderView() {
        view.addSubview(pokemonDetailHeaderView)
        NSLayoutConstraint.activate([
            pokemonDetailHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonDetailHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupBackgroundContainerView() {
        view.addSubview(backgroundContainerView)
        NSLayoutConstraint.activate([
            backgroundContainerView.topAnchor.constraint(equalTo: pokemonDetailHeaderView.bottomAnchor , constant: 8),
            backgroundContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupScollView() {
        backgroundContainerView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: backgroundContainerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: backgroundContainerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: backgroundContainerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: backgroundContainerView.bottomAnchor),
        ])
    }
    
    func setupScrollViewContainer() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: scrollViewContainer.widthAnchor),
        ])
        scrollViewContainer.addArrangedSubview(pokemonInformationView)
        scrollViewContainer.addArrangedSubview(pokemonEvolutionChainView)
    }
}
