//
//  ProductDetailRouter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation

protocol ProductDetailRouterProtocol{
    func navigateToShoppingCart()
}

final class ProductDetailRouter: ProductDetailRouterProtocol{
    weak var viewController: ProductDetailViewController?
    
    init(viewController: ProductDetailViewController) {
        self.viewController = viewController
    }
    
    static func buildDetailVC(with product: Product) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor(basketManager: BasketManager.shared)
        let router = ProductDetailRouter(viewController: ProductDetailViewController())
        
        let presenter = ProductDetailPresenter(view: view as! ProductDetailViewProtocol, interactor: interactor, router: router, product: product)
        
        view.presenter = presenter 
        router.viewController = view
        
        return view
        
    }
    
    func navigateToShoppingCart() {
        let shoppingCartViewController = ShoppingCartListRouter.buildShoppingCartVC()
        viewController?.navigationController?.pushViewController(shoppingCartViewController, animated: true)
    }
}
