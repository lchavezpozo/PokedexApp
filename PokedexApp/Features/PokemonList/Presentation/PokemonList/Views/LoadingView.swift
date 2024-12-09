//
//  LoadingView.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 8/12/24.
//
import UIKit

class LoadingView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pokeballLoading
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func startLoading(parentView: UIView) {
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
        parentView.bringSubviewToFront(self)

        imageView.layer.removeAllAnimations()
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.0
        rotation.isCumulative = true
        rotation.repeatCount = .infinity
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }

    func stopLoading() {
        imageView.layer.removeAllAnimations()
        removeFromSuperview()
    }
}

private extension LoadingView {
    func setupUI() {
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
