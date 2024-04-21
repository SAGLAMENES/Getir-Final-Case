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
    func didProductDelete(product: Product)
    func didProductUpdate(product: Product)
    func didProductTapped(product: Product) -> UIViewController
}

final class ShoppingCartListPresenter{
   
    unowned var viewController: ShoppingCartListViewControllerProtocol!
    let router: ShoppingCartListRouter!
    let interactor: ShoppingCartListInteractor!
    
    init(viewController: ShoppingCartListViewControllerProtocol,
         router: ShoppingCartListRouter,
         interactor: ShoppingCartListInteractor
    ){
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
    
    
}

extension ShoppingCartListPresenter: ShoppingCartListPresenterProtocol{
    func viewDidAppear() {
        interactor.fetchShoppingCartList()
    }
    
    func didProductDelete(product: Product) {
        interactor.didProductDelete(product: product)
    }
    
    func didProductUpdate(product: Product) {
        interactor.didProductUpdate(product: product)
    }
    
   
    func didProductTapped(product: Product) -> UIViewController {
        return ProductDetailRouter.buildDetailVC(with: product)
    }
    
}



