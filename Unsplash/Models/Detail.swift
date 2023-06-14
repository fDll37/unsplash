//
//  Detail.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import Foundation
import CoreData

struct Detail {
    var id: String
    var image: String
    var name: String
    var location: String
    var countDownloads: Int
    var dataCreate: String
}


extension Detail {
    init(data: NSManagedObject) {
        self.id = (data.value(forKey: "id") as? String)!
        self.image = (data.value(forKey: "image") as? String)!
        self.name = (data.value(forKey: "name") as? String)!
        self.location = (data.value(forKey: "location") as? String)!
        self.countDownloads = (data.value(forKey: "countDownloads") as? Int)!
        self.dataCreate = (data.value(forKey: "dataCreate") as? String)!
    }
    
    init(data: Result) {
        self.id = data.id
        self.image = data.urls.small
        self.name = data.user.name
        self.location = data.user.location ?? "Нет информации"
        self.countDownloads = data.downloads ?? 0
        self.dataCreate = data.created_at.formatted(date: .numeric, time: .standard)
    }
}
