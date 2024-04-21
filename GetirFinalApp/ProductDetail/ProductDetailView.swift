//
//  ProductDetailView.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    func showProductDetail(product: Product)
    func setUpView()
}
final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterProtocol!
    var product: Product?
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()
    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .getirColor
        label.textAlignment = .center
        return label
    }()
    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray.withAlphaComponent(0.5)
        label.textAlignment = .center

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    func setUpView() {
        let backButton = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(closeViewController))
        
        backButton.tintColor = .white
            navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = presenter.setTitle()
        view.backgroundColor = .white
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(productDescriptionLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            productPriceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            productPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 3),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    @objc func closeViewController() {
       navigationController?.popViewController(animated: true)
    }
    func showProductDetail(product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceText
        productDescriptionLabel.text = product.attribute
        productImageView.image = UIImage(named: "sepet")
    }
    
}
