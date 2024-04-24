//
//  ShoppingCartListPresenter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
import UIKit

protocol ShoppingCartListPresenterProtocol: AnyObject {
    func viewDidAppear()
    func increaseProductCount(product: Int)
    func decreaseProductCount(at product: Int)
    func didSelectRow(_ index: Int)
    func getShoppingCartListCount() -> Int
    func fetchShoppingCartList()
    func product(index: Int) -> Product?
    func getCartItemNumber(index: Int) -> Int
}

final class ShoppingCartListPresenter{
    
    unowned var view: ShoppingCartListViewControllerProtocol!
    let router: ShoppingCartListRouter!
    let interactor: ShoppingCartListInteractor!
    
    private var cartItems: [String: Int] = [:]
    var products: [Product] = [] {
        didSet {
            view.reloadTableView()
        }
    }
    
    init(view: ShoppingCartListViewControllerProtocol,
         router: ShoppingCartListRouter,
         interactor: ShoppingCartListInteractor
    ){
        self.view = view
        self.router = router
        self.interactor = interactor
        fetchShoppingCartList()
    }
}
    
    


extension ShoppingCartListPresenter: ShoppingCartListPresenterProtocol{
    
    func product(index: Int) -> Product? {
        products[index]
    }
    
    func getShoppingCartListCount() -> Int {
        products.count
    }
    
    func viewDidAppear() {
        view.setUpView()
        
    }
    
    func getCartItemNumber(index: Int) -> Int {
        interactor.getProductNumber(id: products[index].id)
    }
    
    func increaseProductCount(product: Int) {
        interactor.saveProduct(product: products[product])
        print(products)
        }
    
    func decreaseProductCount(at product: Int) {
        interactor.deleteProduct(product: products[product])
    }
    
    func fetchShoppingCartList() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.products = self.interactor.fetchShoppingCartList()
            removeDuplicateProducts()
            DispatchQueue.main.async {
                self.view.reloadTableView()
            }
        }
    }
    func removeDuplicateProducts() {
        var uniqueProducts: [Product] = []
        var productNames: Set<String> = Set()

        for product in products {
            if !productNames.contains(product.name) {
                uniqueProducts.append(product)
                productNames.insert(product.name)
            }
        }

        products = uniqueProducts
    }
    func didSelectRow(_ index: Int){
        router.navigateToProductDetail(product: products[index])
    }
    
    
}



