//
//  ProductListCollectionViewCell.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 18.04.2024.
//

import UIKit
protocol ProductsCellDelegate: AnyObject {
    func didTapIncreaseButton(cell: ProductsCell)
    func didTapDecreaseButton(cell: ProductsCell)
}


final class ProductsCell: UICollectionViewCell {
    
    weak var delegate: ProductsCellDelegate?
    
    static let identifier = "ProductsCell"
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
            countLabel.isHidden = count == 0
            countLabel.backgroundColor = count == 0 ? .clear : .getirColor
            minusButton.isHidden = count == 0
            
            self.reloadInputViews()
        }
    }
    
    
    @objc private func increaseButtonTapped() {
        count += 1
        delegate?.didTapIncreaseButton(cell: self)
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
    
    @objc private func decreaseButtonTapped() {
        count -= 1
        delegate?.didTapDecreaseButton(cell: self)
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
    
    let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.plusButtonStyle()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = UIColor.getirColor
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        button.isHidden = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(productName)
        containerView.addSubview(productPrice)
        containerView.addSubview(productAttribute)
        containerView.addSubview(increaseButton)
        containerView.addSubview(countLabel)
        containerView.addSubview(minusButton)
        
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
            
            increaseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            increaseButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            increaseButton.widthAnchor.constraint(equalToConstant: 20),
            increaseButton.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: increaseButton.bottomAnchor, constant:0 ),
            countLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -0),
            countLabel.widthAnchor.constraint(equalToConstant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            
            minusButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 0),
            minusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -0),
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            minusButton.heightAnchor.constraint(equalToConstant: 20),
            
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







