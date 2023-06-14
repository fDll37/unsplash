//
//  PhotoFromAPI.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//

import Foundation

typealias Results = [Result]

struct Result: Identifiable, Codable {
    let id: String
    var created_at: Date
    var description: String?
    var downloads: Int?
    var urls: URLs
    var user: User
    
}

struct URLs: Codable {
    var small: String
    var full: String
}

struct User: Codable {
    var id: String
    var name: String
    var location: String?
}
