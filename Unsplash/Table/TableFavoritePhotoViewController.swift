//
//  TableFavoritePhotoViewController.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import UIKit
import CoreData

class TableFavoritePhotoViewController: UIViewController {

    private var favoriteData: [NSManagedObject] = []
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getFromCoreData()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFromCoreData()
        
    }
    
    private func getFromCoreData() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteNew")
        favoriteData = CoreDataManager.shared.fetchData(fetchRequest)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.table.reloadData()
        }
    }
    
    private func layout() {
        
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate
extension TableFavoritePhotoViewController: UITableViewDelegate {
    
}
// MARK: UITableViewDataSource
extension TableFavoritePhotoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.width + 60
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self), for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.setupCell(favoriteData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.delete(favoriteData[indexPath.row])
            CoreDataManager.shared.save()
            favoriteData.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailCollectionPhotoViewController()
        let detailData = Detail(data: favoriteData[indexPath.row])
        detailVC.setup(detailData)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
