//
//  ShoppingCartListInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
protocol ShoppingCartListInteractorProtocol: AnyObject {
    func fetchShoppingCartList() -> [Product]
    func deleteProduct(product: Product)
    func saveProduct(product: Product)
}

final class ShoppingCartListInteractor {
   
}

extension ShoppingCartListInteractor: ShoppingCartListInteractorProtocol {
    func deleteProduct(product: Product) {
        BasketManager.shared.removeProduct(product: product)
    }
    func getProductNumber(id: String) -> Int {
        return BasketManager.shared.fetchProductNumber(forProductId: id) ?? 1
    }
    
    func saveProduct(product: Product) {
        BasketManager.shared.updateProduct(product: product)
    }
    func fetchShoppingCartList() -> [Product] {
         return BasketManager.shared.getBasket()
    }
        
}
