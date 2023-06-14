//
//  CollectionPhotoViewController.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit

class CollectionPhotoViewController: UIViewController {

    private var randomPhoto: Results = []
    
    private lazy var searchTextField: UITextField = {
        let text = UITextField()
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 15
        text.textColor = .black
        text.placeholder = "Search"
        text.autocapitalizationType = .none
        text.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var buttonSearch: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc private func searchPhoto() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            Service.shared.searchPhoto(search: self.searchTextField.text ?? "") { results in
                self.randomPhoto = results
                self.imageCollection.reloadData()
            }
        }
    }
    
    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
        return imageCollection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layout()
        
        DispatchQueue.main.async {
            Service.shared.getRandomPhotosInfo { results in
                self.randomPhoto = results
                self.imageCollection.reloadData()
            }
            
        }
        
    }
    
    private func layout(){
        view.addSubview(imageCollection)
        view.addSubview(searchTextField)
        view.addSubview(buttonSearch)
        NSLayoutConstraint.activate([
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: buttonSearch.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 25),
            
            buttonSearch.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            buttonSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonSearch.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            
            imageCollection.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}


// MARK: - UICollectionViewDataSource
extension CollectionPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        randomPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        cell.setupCollectionCell(randomPhoto[indexPath.item].urls.small)
        return cell
    }
    
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailCollectionPhotoViewController()
        let detail = Detail(data: randomPhoto[indexPath.row])
        detailVC.setup(detail)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
