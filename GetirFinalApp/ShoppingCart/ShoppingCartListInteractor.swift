//
//  ShoppingCartListInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
protocol ShoppingCartListInteractorProtocol: AnyObject {
    func fetchShoppingCartList()
    func didProductDelete(product: Product)
    func didProductUpdate(product: Product)
}

final class ShoppingCartListInteractor {
   
}

extension ShoppingCartListInteractor: ShoppingCartListInteractorProtocol {
    func fetchShoppingCartList() {
        BasketManager.shared.getBasket()
    }
    
    func didProductDelete(product: Product) {
        BasketManager.shared.removeProduct(product: product)
    }
    
    func didProductUpdate(product: Product) {
        BasketManager.shared.addProduct(product: product)
    }
    
}
