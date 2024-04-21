//
//  ProductListRouter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation

protocol ProductListRouterProtocol: AnyObject {
    func navigateToProductDetail(product: Product)
    func navigateToShoppingCart()
}
final class ProductListRouter {
    private weak var viewController: ProductListView?
    
    static func createModule() -> ProductListView {
        
        let view = ProductListView()
        let interactor = ProductListInteractor()
        let router = ProductListRouter()
        
        let presenter = ProductListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension ProductListRouter: ProductListRouterProtocol {
    // TODO: - Product Detail View Controller
    func navigateToProductDetail(product: Product) {
        let productDetailVC = ProductDetailRouter.buildDetailVC(with: product)
        viewController?.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func navigateToShoppingCart() {/*
                                    
                                    let shoppingCartVC = ShoppingCartListViewController()
                                    viewController?.navigationController?.pushViewController(shoppingCartVC, animated: true)
                                    */}
}
