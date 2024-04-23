//
//  ProductDetailInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
protocol ProductDetailInteractorProtocol{
    func addProductToBasket(product: Product)
    func deleteProductFromBasket(product: Product)
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol{
    var presenter: ProductDetailPresenterProtocol!
    var basketManager: BasketManagerProtocol!
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
    }
    
    func addProductToBasket(product: Product) {
      //  basketManager.addProduct(product: product)
    }
    
    func deleteProductFromBasket(product: Product) {
        basketManager.removeProduct(product: product)
    }
     
}
