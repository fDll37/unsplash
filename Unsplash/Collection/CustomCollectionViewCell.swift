//
//  CustomCollectionViewCell.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private let imageCollection: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionCell(_ urlImage: String) {
        DispatchQueue.main.async {
            Service.shared.getImage(url: urlImage) { image in
                self.imageCollection.image = image
            }
        }
    }
    
    private func layout(){
        contentView.addSubview(imageCollection)
        NSLayoutConstraint.activate([
            imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}
