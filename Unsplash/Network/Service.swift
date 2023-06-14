//
//  Service.swift
//  Unsplash
//
//  Created by Данил Менделев on 12.06.2023.
//
import UIKit
import Foundation


class Service {
    
    static let shared = Service()
    
    private init() {}
    
    private let endPoint = "https://api.unsplash.com"
    private let accessKey = "LeZhM1GC9VYzsa9ozjbfyow2cOysIMkvJJJ4uIlWqq0"
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func searchPhoto(search: String, completion: @escaping ([Result])-> Void) {
        let url = URL(string: "\(endPoint)/search/photos?client_id=\(accessKey)&query=\(search)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
//            guard let response = response as? HTTPURLResponse else {return}
//
//            print(response.statusCode)
            do {
                let resultRequest = try Service.shared.jsonDecoder.decode(Search.self, from: data)
                if !resultRequest.results.isEmpty {
                    DispatchQueue.main.async {
                        completion(resultRequest.results)
                    }
                }
            }
            catch {
                print("Error get from API(search):")
                print(error)
            }
        }.resume()
    }
    
    func getRandomPhotosInfo(completion: @escaping ([Result])-> Void) {
        let url = URL(string: "\(endPoint)/photos/random?client_id=\(accessKey)&count=10")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
//            guard let response = response as? HTTPURLResponse else {return}
//            print(response.statusCode)
            do {
                let resultRequest = try Service.shared.jsonDecoder.decode(Results.self, from: data)
                DispatchQueue.main.async {
                    completion(resultRequest)
                }
            }
            catch {
                print("Error get from API(random):")
                print(error)
            }
        }.resume()
    }
    
    func getImage(url: String, completion: @escaping (UIImage)-> Void) {
        guard let url = URL(string: url) else {return}        
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {
                print("data error")
                return
            }
            guard let image = UIImage(data: data) else {
                print("image error")
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
