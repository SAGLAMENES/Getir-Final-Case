//
//  GetirService.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 18.04.2024.
//

import Foundation
//
//  GetirApiService.swift
//  GetirApi
//
//  Created by Enes Saglam on 16.04.2024.
//

import Foundation

protocol GetirServiceProtocol {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func getSuggestedProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class GetirService: GetirServiceProtocol{
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/products") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                let products = categories[0].products
                guard let p = products else {
                    completion(.failure(NSError(domain: "No products", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(p))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func getSuggestedProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Category].self, from: data)
                completion(.success(products[0].products!))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
struct Category: Codable {
    let id: String
    let name: String?
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let id, name: String
    let number : Int?
    let attribute: String?
    let  imageURL: String?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
}




