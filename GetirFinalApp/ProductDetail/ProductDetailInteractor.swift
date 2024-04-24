//
//  ProductDetailInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
protocol ProductDetailInteractorProtocol{
    func deleteProduct(product: Product)
    func saveProduct(product: Product)
    func getProductNumber(id: String) -> Int
    
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol{
    func getProductNumber(id: String) -> Int {
        return BasketManager.shared.fetchProductNumber(forProductId: id) ?? 0
    }
    func deleteProduct(product: Product) {
        BasketManager.shared.removeProduct(product: product)
    }
    
    func saveProduct(product: Product) {
        BasketManager.shared.updateProduct(product: product)
    }
    
    var presenter: ProductDetailPresenterProtocol!
    var basketManager: BasketManagerProtocol!
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
    }
    
   
     
}
