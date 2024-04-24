//
//  ProductDetailPresenter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
import UIKit


protocol ProductDetailPresenterProtocol: AnyObject{
    func viewDidLoad()
    func increaseProductCount(product: Product)
    func decreaseProductCount(product: Product)
    func getCartItemNumber(product: Product) -> Int
    func setTitle() -> String
    func tappedShoppingCart()
}

final class ProductDetailPresenter{
    unowned var view: ProductDetailViewProtocol!
    private let interactor: ProductDetailInteractorProtocol
    private let router: ProductDetailRouterProtocol
    private let product: Product
    
    init(view: ProductDetailViewProtocol, 
         interactor: ProductDetailInteractorProtocol,
         router: ProductDetailRouterProtocol,
         product: Product) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.product = product
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol{
 
    func getCartItemNumber(product: Product) -> Int {
        interactor.getProductNumber(id: product.id)
    }
    
    func increaseProductCount(product: Product) {
        interactor.saveProduct(product: product)
    }
    
    func decreaseProductCount(product: Product) {
        interactor.deleteProduct(product: product)
    }
    
    func setTitle() -> String {
        "Ürün Detayı"
    }
    
    func viewDidLoad() {
       // view.setProductDetail(product: product)
        view.setUpView()
        view.showProductDetail(product: product)
        
    }
    
    func tappedShoppingCart() {
        router.navigateToShoppingCart()
    }
    
}
