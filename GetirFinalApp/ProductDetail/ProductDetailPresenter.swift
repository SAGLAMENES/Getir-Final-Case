//
//  ProductDetailPresenter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation


protocol ProductDetailPresenterProtocol: AnyObject{
    func viewDidLoad()
    func addProductToCart()
    func increaseProductAmount()
    func decreaseProductAmount()
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
    func viewDidLoad() {
       // view.setProductDetail(product: product)
        view.setUpView()
        view.showProductDetail(product: product)
    }
    
    func addProductToCart() {
        //interactor.addProductToCart(product: product)
    }
    
    func increaseProductAmount() {
       // interactor.increaseProductAmount(product: product)
    }
    
    func decreaseProductAmount() {
        //interactor.decreaseProductAmount(product: product)
    }
    
    func tappedShoppingCart() {
        router.navigateToShoppingCart()
    }
}
