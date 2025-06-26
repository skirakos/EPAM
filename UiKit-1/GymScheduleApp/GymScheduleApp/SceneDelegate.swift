//
//  SceneDelegate.swift
//  GymScheduleApp
//
//  Created by Seda Kirakosyan on 21.06.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController() // ← Your custom root VC
        window.makeKeyAndVisible()
        self.window = window
    }
}
