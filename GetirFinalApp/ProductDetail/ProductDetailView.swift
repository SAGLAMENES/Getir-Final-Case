//
//  ProductDetailView.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import UIKit
import SDWebImage
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
    let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.plusButtonStyle()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc private func increaseButtonTapped() {
        count += 1
        UIView.transition(with: increaseButton,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            if self.count == 1 {
                self.minusButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
            } else {
                self.minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
            }
        }, completion: nil)
    }
    let minusButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = UIColor.getirColor
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    @objc private func decreaseButtonTapped() {
        count -= 1
        UIView.transition(with: minusButton,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            if self.count == 1 {
                self.minusButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
            } else {
                self.minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
            }
        }, completion: nil)
    }

    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textAlignment = .center
        label.backgroundColor = .getirColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var count: Int = 1 {
        didSet {
            countLabel.text = "\(count)"
            minusButton.imageView?.image = UIImage(systemName: count == 1 ? "trash.fill" : "minus")
            self.reloadInputViews()
        }
    }
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .getirColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    @objc func addButton() {
        presenter.increaseProductCount(product: product!)
    }
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
        view.addSubview(addToCartButton)
        view.addSubview(increaseButton)
        view.addSubview(minusButton)
        view.addSubview(countLabel)
        
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
            
            addToCartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            
            minusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            minusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            minusButton.widthAnchor.constraint(equalToConstant: 32),
            minusButton.heightAnchor.constraint(equalToConstant: 32),

            countLabel.topAnchor.constraint(equalTo: minusButton.topAnchor, constant: 0),
            countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 0),
            countLabel.widthAnchor.constraint(equalToConstant: 32),
            countLabel.heightAnchor.constraint(equalToConstant: 32),

            increaseButton.topAnchor.constraint(equalTo: minusButton.topAnchor, constant: 0),
            increaseButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 0),
            increaseButton.widthAnchor.constraint(equalToConstant: 32),
            increaseButton.heightAnchor.constraint(equalToConstant: 32),
            
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
        productImageView.sd_setImage(with: URL(string: product.imageURL ?? "notFound"), completed: nil)
        
        count = presenter.getCartItemNumber(product: product)
        if count == 0 {
            addToCartButton.isHidden = false
            minusButton.isHidden = true
            countLabel.isHidden = true
            increaseButton.isHidden = true
        }else {
            addToCartButton.isHidden = true
            minusButton.isHidden = false
            countLabel.isHidden = false
            increaseButton.isHidden = false
        }
        
        countLabel.text = count.description
    }
    
}
