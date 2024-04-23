//
//  ProductListInteractor.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation

protocol ProductListInteractorProtocol: AnyObject {
    func fetchProducts()
    func fetchSuggestedProducts()
    func saveProduct(product: Product)
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    func fetchProductsOutput(products: [Product])
    func fetchSuggestedProductsOutput(suggestedProducts: [Product])
    func fetchProductImageOutput(imageData: Data)

}

final class ProductListInteractor{
    var output: ProductListInteractorOutputProtocol?

}

extension ProductListInteractor: ProductListInteractorProtocol{
    func saveProduct(product: Product) {
        
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
