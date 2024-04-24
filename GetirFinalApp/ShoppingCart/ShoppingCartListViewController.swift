//
//  ShoppingCartListView.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import UIKit


protocol ShoppingCartListViewControllerProtocol: AnyObject {
    func reloadTableView()
    func setUpView()
}
final class ShoppingCartListViewController: UIViewController{
    
    var presenter: ShoppingCartListPresenterProtocol!
    let tableView = UITableView()
    
    let completeShopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .getirColor
        button.layer.cornerRadius = 10
        button.setTitle("Alışverişi Tamamla", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()

    }

   
    
}

extension ShoppingCartListViewController: ShoppingCartListViewControllerProtocol {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
 
    func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShoppingCell.self, forCellReuseIdentifier: ShoppingCell.identifier)
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(completeShopButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            completeShopButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            completeShopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            completeShopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeShopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}

extension ShoppingCartListViewController: UITableViewDelegate, UITableViewDataSource, ShoppingCellDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getShoppingCartListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCell.identifier, for: indexPath) as! ShoppingCell
        guard let item = presenter.product(index: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: item, number: presenter.getCartItemNumber(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func didTapIncreaseButton(cell: ShoppingCell) {
        let  indexPath = tableView.indexPath(for: cell)
        presenter.increaseProductCount(product: indexPath?.row ?? 0)
    }
    
    func didTapDecreaseButton(cell: ShoppingCell) {
        let  indexPath = tableView.indexPath(for: cell)
        presenter.decreaseProductCount(at: indexPath?.row ?? 0)
    }
}


