//
//  CustomTableViewCell.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit
import CoreData

class CustomTableViewCell: UITableViewCell {
    
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell (_ data: NSManagedObject) {
        DispatchQueue.main.async {
            Service.shared.getImage(url: (data.value(forKey: "image") as? String)!) { image in
                self.photo.image = image
            }
        }
        self.nameAuthor.text = data.value(forKey: "name") as? String
    }
    
    private func layout() {
        
        contentView.addSubview(photo)
        contentView.addSubview(nameAuthor)
        
        let constant: CGFloat = 10
        let width = UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            
            nameAuthor.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: constant),
            nameAuthor.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: constant),
            nameAuthor.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
            
            photo.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: constant),
            photo.leadingAnchor.constraint(equalTo: nameAuthor.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: nameAuthor.trailingAnchor),
//            photo.widthAnchor.constraint(equalToConstant: width),
            photo.heightAnchor.constraint(equalToConstant: width),
            
        ])
    }
}
