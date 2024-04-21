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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(productDescriptionLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 20),
            productPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 20),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func showProductDetail(product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceText
        productDescriptionLabel.text = product.attribute
        productImageView.image = UIImage(named: "sepet")
    }
    
}
