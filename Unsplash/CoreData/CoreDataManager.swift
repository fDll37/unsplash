//
//  CoreDataManager.swift
//  Unsplash
//
//  Created by Данил Менделев on 13.06.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let appDelegate: AppDelegate
    private let managedContext: NSManagedObjectContext
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        managedContext.delete(object)
    }
    
    func fetchData(_ request:  NSFetchRequest<NSManagedObject>) -> [NSManagedObject] {
        do {
            let result = try managedContext.fetch(request)
            return result
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
            return []
        }
    }
    
    func createNewFavorite(_ data: Detail) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteNew", in: managedContext)!
        let newFavorite = NSManagedObject(entity: entity, insertInto: managedContext)
        newFavorite.setValue(data.name, forKeyPath: "name")
        newFavorite.setValue(data.id, forKey: "id")
        newFavorite.setValue(data.dataCreate, forKey: "dataCreate")
        newFavorite.setValue(data.location, forKey: "location")
        newFavorite.setValue(data.countDownloads, forKey: "countDownloads")
        newFavorite.setValue(data.image, forKey: "image")
        return newFavorite
    }
    
}
