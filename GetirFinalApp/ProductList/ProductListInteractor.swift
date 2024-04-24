//
//  ProductListInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
import SDWebImage

protocol ProductListInteractorProtocol: AnyObject {
    func fetchProducts()
    func fetchSuggestedProducts()
    func saveProduct(product: Product)
    func deleteProduct(product: Product)
    func getProductNumber(id: String) -> Int
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    func fetchProductsOutput(products: [Product])
    func fetchSuggestedProductsOutput(suggestedProducts: [Product])

}

final class ProductListInteractor{
    var output: ProductListInteractorOutputProtocol?
    var presenter: ProductListPresenterProtocol!
}

extension ProductListInteractor: ProductListInteractorProtocol{
    func deleteProduct(product: Product) {
        BasketManager.shared.removeProduct(product: product)
    }
    func getProductNumber(id: String) -> Int {
        return BasketManager.shared.fetchProductNumber(forProductId: id) ?? 0
    }
    func saveProduct(product: Product) {
        BasketManager.shared.updateProduct(product: product)
    }
    
    
    func fetchProducts() {
        let service = GetirService()
        service.getProducts {[weak self] result in
            switch result{
            case .success(let data):
                self?.output?.fetchProductsOutput(products: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    func fetchSuggestedProducts() {
        let service = GetirService()
        service.getSuggestedProducts {[weak self] result in
            switch result{
            case .success(let data):
                self?.output?.fetchSuggestedProductsOutput(suggestedProducts: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
