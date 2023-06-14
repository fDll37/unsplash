//
//  TabBarViewController.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private lazy var collectionPhoto = CollectionPhotoViewController()
    private lazy var tableFavorite = TableFavoritePhotoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        collectionPhoto.tabBarItem.title = "Коллекция"
        tableFavorite.tabBarItem.title = "Таблица"
        
        collectionPhoto.tabBarItem.image = UIImage(systemName: "photo.stack")
        tableFavorite.tabBarItem.image = UIImage(systemName: "tablecells")
        
        let collectionNavigationController = UINavigationController(rootViewController: collectionPhoto)
        let tableNavigationController = UINavigationController(rootViewController: tableFavorite)
        
        viewControllers = [collectionNavigationController, tableNavigationController]

    }
    
}
