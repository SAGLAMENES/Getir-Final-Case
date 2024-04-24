//
//  ShoppingCell.swift
//  GetirFinalApp
//
//  Created by Enes Saglam on 24.04.2024.
//

import UIKit
import SDWebImage
protocol ShoppingCellDelegate: AnyObject {
    func didTapIncreaseButton(cell: ShoppingCell)
    func didTapDecreaseButton(cell: ShoppingCell)
}

final class ShoppingCell: UITableViewCell {
    
    weak var delegate: ShoppingCellDelegate?
    
     static let identifier = "ShoppingCell"
    
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
    
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
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
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            productImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            productImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            productImage.widthAnchor.constraint(equalToConstant: 78),
            productImage.heightAnchor.constraint(equalToConstant: 78),
            
            productName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            productName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            productName.heightAnchor.constraint(equalToConstant: 40),
            productName.widthAnchor.constraint(equalToConstant: 131),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 4),
            productPrice.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            productPrice.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            productAttribute.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 4),
            productAttribute.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            productAttribute.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            increaseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                increaseButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -0),
                increaseButton.widthAnchor.constraint(equalToConstant: 32),
                increaseButton.heightAnchor.constraint(equalToConstant: 32),
                
                countLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                countLabel.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: 0),
                countLabel.widthAnchor.constraint(equalToConstant: 32),
                countLabel.heightAnchor.constraint(equalToConstant: 32),
                
                minusButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: 0),
                minusButton.widthAnchor.constraint(equalToConstant: 32),
                minusButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    func configure(with product: Product, number: Int) {
        let imageURL = URL(string: product.imageURL!)
        productImage.sd_setImage(with: imageURL) { (image, error, cacheType, imageUrl) in
            if let error = error {
             
                return
            }
            
            guard let image = image else {
                return
            }
            
            if let pngImageData = image.pngData() {
                self.productImage.image = UIImage(data: pngImageData)
            } else {
            }
        }
        productName.text = product.name
        count = number
        countLabel.text = number.description
        productPrice.text = "\(product.price ?? 0) TL"
        productAttribute.text = product.attribute
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
    
    
}
