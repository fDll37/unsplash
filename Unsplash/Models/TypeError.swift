//
//  TypeError.swift
//  Unsplash
//
//  Created by Данил Менделев on 13.06.2023.
//

import Foundation

enum TypeError: Error {
    
    enum Network: Error {
        case auth
        case imageLoad
        case imageInfo
    }
    
    enum CoreData: Error {
        case badSave
        case badFetch
        case badDelete
    }
}
