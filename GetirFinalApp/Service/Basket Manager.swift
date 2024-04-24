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
    func updateProduct(product: Product)
    func removeProduct(product: Product)
    func clearBasket()
    func fetchProductNumber(forProductId productId: String) -> Int?
}
final class BasketManager: BasketManagerProtocol {
    static let shared = BasketManager()
    private var basket: [Product] = []
    
    func fetchProductNumber(forProductId productId: String) -> Int? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        request.predicate = NSPredicate(format: "id = %@", productId)
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if let productData = results.first as? NSManagedObject {
                let number = productData.value(forKey: "number") as? Int
                return number
            }
        } catch {
            print("Error fetching product number:", error)
        }
        return nil
    }
    func getBasket() -> [Product] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        do {
            let results = try context.fetch(request)
            for result in results {
                if let productData = result as? NSManagedObject {
                    let name = productData.value(forKey: "name") as! String
                    let id = productData.value(forKey: "id") as! String
                    let imageURL = productData.value(forKey: "image") as! String
                    let attribute = productData.value(forKey: "attribute") as? String
                    let price = productData.value(forKey: "price") as! Double
                    let number = productData.value(forKey: "number") as! Int
                    let product = Product(id: id, name: name, number: number, attribute: attribute ?? "", imageURL: imageURL, price: price, priceText: ("TL\(price)"), shortDescription: "")
                        basket.append(product)
                }
            }
        } catch {
            print("Veri getirilemedi")
        }
        return basket
    }
    
    func updateProduct(product: Product) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        request.predicate = NSPredicate(format: "id = %@", product.id)
        
        do {
            let results = try context.fetch(request)
            if let existingProductData = results.first as? NSManagedObject {
                guard var currentCount = existingProductData.value(forKey: "number") as? Int else {
                    print("Error: Unable to retrieve current product number")
                    return
                }
                currentCount += 1
                print("Product ID:", product.id)
                print("Current Count:", currentCount)
                existingProductData.setValue(currentCount, forKey: "number")
                try context.save()
                print("Product count incremented successfully")
            } else {
                let newProduct = NSEntityDescription.insertNewObject(forEntityName: "ProductData", into: context)
                newProduct.setValue(product.name, forKey: "name")
                newProduct.setValue(product.attribute, forKey: "attribute")
                newProduct.setValue(product.imageURL, forKey: "image")
                newProduct.setValue(product.price, forKey: "price")
                newProduct.setValue(product.id, forKey: "id")
                newProduct.setValue(1, forKey: "number") // Initial count for new product
                try context.save()
                print("New product saved successfully")
            }
        } catch {
            print("Error updating product:", error)
        }
    }


    
    func removeProduct(product: Product) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
            request.predicate = NSPredicate(format: "id = %@", product.id)
            
            do {
                let results = try context.fetch(request)
                for result in results {
                    if let productData = result as? NSManagedObject {
                        let currentCount = productData.value(forKey: "number") as? Int ?? 0
                        if currentCount > 1 {
                            productData.setValue(currentCount - 1, forKey: "number")
                        } else if currentCount == 1{
                            context.delete(productData)
                        }
                    }
                }
                try context.save()
                print("Product updated successfully")
            } catch {
                print("Error updating product:", error)
            }
    }
    
    func clearBasket() {
        basket.removeAll()
    }
}
