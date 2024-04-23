//
//  Basket Manager.swift
//  GetirFinalApp
//
//  Created by Enes Saglam on 21.04.2024.
//

import Foundation
import UIKit
import CoreData
protocol BasketManagerProtocol {
    func getBasket() -> [Product]
    func updateProduct(product: Product, productNum: Int)
    func removeProduct(product: Product)
    func clearBasket()
}
final class BasketManager: BasketManagerProtocol {
    static let shared = BasketManager()
    private var basket: [Product] = []
    
    func getBasket() -> [Product] {
        return basket
    }
    
    func updateProduct(product: Product, productNum: Int) {
        basket.append(product)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newProduct = NSEntityDescription.insertNewObject(forEntityName: "ProductData", into: context)
        newProduct.setValue(product.name, forKey: "name")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(productNum, forKey: "number")
        /*let imageData = product.imageURL?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image")*/
        
        do {
            try context.save()
        } catch {
            print("Veri kaydedilemedi")
        }
        
        
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
