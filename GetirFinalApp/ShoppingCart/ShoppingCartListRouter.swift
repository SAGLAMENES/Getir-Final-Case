//
//  ShoppingCartListRouter.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation

protocol ShoppingCartListRouterProtocol: AnyObject {
    func navigateToDetail(product: Product)
}

final class ShoppingCartListRouter: ShoppingCartListRouterProtocol{
    func navigateToDetail(product: Product) {
        let detailVC = ProductDetailRouter.buildDetailVC(with: product)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    weak var viewController: ShoppingCartListViewController?
    
    init(viewController: ShoppingCartListViewController) {
        self.viewController = viewController
    }
    
    static func buildShoppingCartVC() -> ShoppingCartListViewController {
        let view = ShoppingCartListViewController()
        let interactor = ShoppingCartListInteractor()
        let router = ShoppingCartListRouter(viewController: view)
        
        let presenter = ShoppingCartListPresenter(viewController: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
        
    }
   
}
