//
//  ShoppingCartListView.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import UIKit


protocol ShoppingCartListViewControllerProtocol: AnyObject {
    
}
final class ShoppingCartListViewController: UIViewController{
    
    var presenter: ShoppingCartListPresenterProtocol!
    let collecctionView = UICollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

extension ShoppingCartListViewController: ShoppingCartListViewControllerProtocol {
    
}


class UIviewcontroller: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
