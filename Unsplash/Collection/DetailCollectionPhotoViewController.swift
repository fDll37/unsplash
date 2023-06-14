//
//  DetailCollectionPhotoViewController.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit
import CoreData

class DetailCollectionPhotoViewController: UIViewController {
    
    private var data: Detail!
    
    private var createObject: NSManagedObject!
    
    private var isFavorite: Bool = false
    
    private lazy var scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataCreate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countDownloads: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonAddFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.circle"), for: .normal)
        button.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    @objc private func addFavorite() {
        if isFavorite {
            isFavorite.toggle()
            statusText.text = "Удалено из избранного"
            statusText.textColor = .systemRed
            CoreDataManager.shared.delete(createObject)
            CoreDataManager.shared.save()
        } else {
            isFavorite.toggle()
            statusText.text = "добавлено в избранное"
            statusText.textColor = .systemGreen
            createObject = CoreDataManager.shared.createNewFavorite(data)
            CoreDataManager.shared.save()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
    }
    
    func setup(_ data: Detail) {
        self.data = data
        DispatchQueue.main.async {
            Service.shared.getImage(url: data.image, completion: { image in
                self.image.image = image
            })
        }
        nameAuthor.text = "Автор фото: \(data.name)"
        dataCreate.text = "Дата создания: \(data.dataCreate)"
        location.text = "Локация: \(data.location)"
        countDownloads.text = "Количество скачиваний: \(data.countDownloads)"
    }
    
    private func layout() {
        view.addSubview(scroll)
        [image, nameAuthor, dataCreate, location, countDownloads, buttonAddFavorite, statusText].forEach { scroll.addSubview($0)}
        
        let width = UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: width - 20),
            image.widthAnchor.constraint(equalToConstant: width - 20),
            
            nameAuthor.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            nameAuthor.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            nameAuthor.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -10),
            
            dataCreate.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 10),
            dataCreate.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            dataCreate.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -10),
            
            location.topAnchor.constraint(equalTo: dataCreate.bottomAnchor, constant: 10),
            location.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            location.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -10),
            
            countDownloads.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 10),
            countDownloads.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            countDownloads.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -10),
            
            buttonAddFavorite.topAnchor.constraint(equalTo: countDownloads.bottomAnchor, constant: 10),
            buttonAddFavorite.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            
            statusText.topAnchor.constraint(equalTo: buttonAddFavorite.bottomAnchor, constant: 10),
            statusText.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            statusText.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -10)
            ])
    }
    
}
