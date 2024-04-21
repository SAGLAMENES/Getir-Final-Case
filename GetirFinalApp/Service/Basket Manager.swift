//
//  Basket Manager.swift
//  GetirFinalApp
//
//  Created by Enes Saglam on 21.04.2024.
//

import Foundation

protocol BasketManagerProtocol {
    func getBasket() -> [Product]
    func addProduct(product: Product)
    func removeProduct(product: Product)
    func clearBasket()
}
final class BasketManager: BasketManagerProtocol {
    static let shared = BasketManager()
    private var basket: [Product] = []
    
    func getBasket() -> [Product] {
        return basket
    }
    
    func addProduct(product: Product) {
        basket.append(product)
    }
    
    func removeProduct(product: Product) {
        if let index = basket.firstIndex(where: { $0.id == product.id }) {
            basket.remove(at: index)
        }
    }
    
    func clearBasket() {
        basket.removeAll()
    }
}
