//
//  SceneDelegate.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 4/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        InfrastructureProvider.initializeCoreData()
        let window = UIWindow(windowScene: windowScene)
        let coordinator = PokemonListCoordinator(window: window)
        self.window = window
        coordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
