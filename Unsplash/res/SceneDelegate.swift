//
//  SceneDelegate.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarVC = TabBarViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarVC
        // если строку выше комментировать, то просто черный экран и ничего дальше
        let collectionVC = CollectionPhotoViewController()
        self.window?.rootViewController = collectionVC
        self.window = window
        window.makeKeyAndVisible()
        
    }

}

