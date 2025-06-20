//
//  SceneDelegate.swift
//  MultiTabApllication
//
//  Created by Seda Kirakosyan on 16.06.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
            _ scene: UIScene,
            willConnectTo session: UISceneSession,
            options connectionOptions: UIScene.ConnectionOptions
        ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabViewController() 
        window?.makeKeyAndVisible()
    }
}
