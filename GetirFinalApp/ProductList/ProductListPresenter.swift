//
//  ProductListPresenter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
import UIKit

protocol ProductListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems(section: Int) -> Int?
    func product(_ index: Int) -> Product?
    func setTitle() -> String
    func suggestedProduct(_ index: Int) -> Product?
    func didSelectProduct(at index: Int, at section: String)
    func tappedShoppingCart()
    func increaseProductCount(product: Product)
    func decreaseProductCount(product: Product)
    func setCartCount() -> String
    func getCartItemNumber(index: Int) -> Int 
}


final class ProductListPresenter {
    unowned var view: ProductListViewProtocol!
    let interactor: ProductListInteractorProtocol!
    let router: ProductListRouterProtocol!
    
    private var products: [Product] = []
    private var suggestedProducts: [Product] = []
    init(view: ProductListViewProtocol,
         interactor: ProductListInteractorProtocol,
         router: ProductListRouterProtocol)
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension ProductListPresenter: ProductListPresenterProtocol{
  
    func setCartCount() -> String {
        let total = calculateTotalPrice()
        view.reloadNavigationBar()
        view.reloadData()
        return "\(total)"
    }

    func calculateTotalPrice() -> Double {
        var total: Double = 0
        for product in products {
            let count = interactor.getProductNumber(id: product.id)
            total += Double(count) * (product.price ?? 7)
        }
        view.reloadNavigationBar() // Move the view update before returning the total
        return total
    }

    
    func increaseProductCount(product: Product) {
        interactor.saveProduct(product: product)
        view.reloadNavigationBar()
    }
    func getCartItemNumber(index: Int) -> Int {
        interactor.getProductNumber(id: products[index].id)
    }
    func decreaseProductCount(product: Product) {
        interactor.deleteProduct(product: product)
    }
    
    func setTitle() -> String {
        "Ürünler"
    }
    
    
    enum Section: Int {
        case vertical
        case horizontal
    }
    func viewDidLoad() {
        
        view.setUpNavigationBar()
        fetchProducts()
        view.setUpCollectionView()
    }
    
    func numberOfItems(section: Int) -> Int? {
        switch section {
        case 1:
            return products.count
        case 0:
            return suggestedProducts.count
        default:
            return 1
        }
    }
    
    func didSelectProduct(at index: Int, at section: String) {
        if section == "vertical" {
            router.navigateToProductDetail(product: products[index])
        }
        else {
            router.navigateToProductDetail(product: suggestedProducts[index])
        }
    }
    func product(_ index: Int) -> Product? {
        products[ index]
    }
    func suggestedProduct(_ index: Int) -> Product? {
        suggestedProducts[index]
    }
    
    @objc func tappedShoppingCart() {
        router.navigateToShoppingCart()
    }
    func fetchProducts(){
        interactor.fetchProducts()
        interactor.fetchSuggestedProducts()
    }
    
}

extension ProductListPresenter: ProductListInteractorOutputProtocol{
    func fetchSuggestedProductsOutput(suggestedProducts: [Product]) {
        DispatchQueue.main.async {
            self.suggestedProducts = suggestedProducts
            print(suggestedProducts)
            self.view.reloadData()
        }
    }
    
    func fetchProductsOutput(products: [Product]) {
        DispatchQueue.main.async {
            self.products = products
            self.view.reloadData()
        }
    }
}
