//
//  ProductListPresenter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation

protocol ProductListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems(section: Int) -> Int?
    func didAddProduct(at index: Int) -> Product
    func product(_ index: Int) -> Product?
    func suggestedProduct(_ index: Int) -> Product?
    func didSelectProduct(at index: Int)
    func tappedShoppingCart()
   
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
    
    
    func didAddProduct(at index: Int) -> Product {
        return products[index]
    }
    
    func didSelectProduct(at index: Int) {
        router.navigateToProductDetail(product: products[index])
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
