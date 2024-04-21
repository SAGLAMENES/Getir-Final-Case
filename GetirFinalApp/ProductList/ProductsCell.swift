//
//  ProductListCollectionViewCell.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 18.04.2024.
//

import UIKit

final class ProductsCell: UICollectionViewCell {
    
    static let identifier = "ProductsCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // Set background color for the entire cell
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .getirColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productAttribute: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.applyCustomStyle()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(productName)
        containerView.addSubview(productPrice)
        containerView.addSubview(productAttribute)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 164.67),
            containerView.widthAnchor.constraint(equalToConstant: 103.67),
            
            productImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            productImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -0),
            productImage.heightAnchor.constraint(equalToConstant: 103.67),
            productImage.widthAnchor.constraint(equalToConstant: 103.67),
            
            actionButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            actionButton.widthAnchor.constraint(equalToConstant: 20),
            actionButton.heightAnchor.constraint(equalToConstant: 20),
            
            productName.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 2),
            productName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -0),
            
            productPrice.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 2),
            productPrice.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productPrice.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            productAttribute.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 2),
            productAttribute.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productAttribute.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
        ])
    }
    
    
    func configure(with name: String, price: String, attribute: String, image: String?) {
        productName.text = name.truncateToFourWords()
        productPrice.text = "\(price)"
        productAttribute.text = attribute
        productImage.image = UIImage(named: "sepet")
    }
}


final class SuggestedProductCell: UICollectionViewCell{
    
    static let identifier = "SuggestedProductCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // Set background color for the entire cell
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .getirColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productAttribute: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(productName)
        containerView.addSubview(productPrice)
        containerView.addSubview(productAttribute)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0)])
    }
}
            
                                                    
                                                    
                                        
                                                    
