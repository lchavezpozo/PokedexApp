//
//  EmptyResultView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 9/12/24.
//
import UIKit

class EmptyResultView: UIView {
    var onTapRetryButton: (() -> Void)? = nil

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .magikarp
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tenemos problemas con una magikarp, intenta nuevamente"
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Intentar nuevamente", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addRetryActionButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRetryActionButton() {
        retryButton.addAction(UIAction { [weak self] _ in
            self?.onTapRetryButton?()
        }, for: .touchUpInside)
    }
}

private extension EmptyResultView {
    func setupUI() {
        setupImageView()
        setupMessageLabel()
        setupRetryButton()
    }

    func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setupMessageLabel() {
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
           messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setupRetryButton() {
        addSubview(retryButton)
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 280),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
