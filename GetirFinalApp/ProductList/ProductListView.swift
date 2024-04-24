//
//  ProductsViewController.swift
//  Getir-FinalCase
//
//  Created by Enes Saglam on 15.04.2024.
//

import Foundation
import UIKit

protocol ProductListViewProtocol: AnyObject {
    func reloadData()
    func setUpCollectionView()
    func setUpNavigationBar()
    func reloadNavigationBar()
    func showLoadingView()
    func hideLoadingView()
}

final class ProductListView: UIViewController {
    
    var presenter: ProductListPresenterProtocol!
    var sections : [String] = ["horizontal", "vertical"]
    
    private var collectionView : UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad()
    }
    
    private func createLay() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section{
            case "horizontal":
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case "vertical":
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.22))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            default:
                return nil
            }
            
        }
        
        return layout
    }
}

extension ProductListView: ProductListViewProtocol {
    func reloadNavigationBar() {
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setUpCollectionView() {
        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLay())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.identifier)
        collectionView.register(ProductsCellHorizontal.self, forCellWithReuseIdentifier: ProductsCellHorizontal.identifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 16)
        ])
        
    }
    
    func setUpNavigationBar() {
        navigationItem.title = presenter.setTitle()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 91, height: 34))
        
        let imageView = UIImageView(image: UIImage(named: "Icon")) // Set your image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        customView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 35, y: 8, width: 50, height: 20))
        label.lineBreakMode = .byWordWrapping
        label.text = "\(presenter.setCartCount())₺"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.getirColor
        
        customView.addSubview(label)
        
        customView.layer.borderWidth = 1
        customView.layer.borderColor = UIColor.getirColor.cgColor
        customView.backgroundColor = #colorLiteral(red: 0.9595986009, green: 0.9542704225, blue: 0.9845344424, alpha: 1)
        customView.layer.cornerRadius = 8
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedShoppingCart))
        
        customView.addGestureRecognizer(tap)
        
        let customBarButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.rightBarButtonItem = customBarButtonItem
        navigationItem.rightBarButtonItem?.target = self
    }
    
    func showLoadingView() {
        // Implement loading view display
    }
    
    func hideLoadingView() {
        // Implement loading view hide
    }
    
    @objc func tappedShoppingCart() {
        presenter.tappedShoppingCart()
    }
}


extension ProductListView: UICollectionViewDelegate, UICollectionViewDataSource, ProductsCellDelegate, ProductsCellHorizontalDelegate {
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section]{
        case "vertical":
            
            presenter.didSelectProduct(at: indexPath.row, at: "vertical")
            
        case "horizontal":
            presenter.didSelectProduct(at: indexPath.row, at: "horizontal")
            
        default:
            presenter.didSelectProduct(at: indexPath.row, at: "vertical")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case "vertical":
            guard let itemsCount = presenter?.numberOfItems(section: 1) else {
                return 1 }
            return itemsCount
        case "horizontal":
            guard let itemsCount = presenter?.numberOfItems(section: 0) else {
                return 1 }
            return itemsCount
            
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case "horizontal":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCellHorizontal.identifier, for: indexPath) as? ProductsCellHorizontal else {
                        fatalError("Expected ⁠ ProductsCellHorizontal ⁠ type for reuseIdentifier \(ProductsCellHorizontal.identifier).")
                    }

            
            let products = presenter?.suggestedProduct(indexPath.row)
            guard let image = products?.imageURL else {
                return UICollectionViewCell()
            }
            cell.configure(with: products?.name ?? "000", price: products?.priceText ?? "000", attribute: products?.attribute ?? "", image: products?.imageURL ?? image )
            cell.backgroundColor = .gray
            cell.delegate = self
            return cell
            
        case "vertical":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.identifier, for: indexPath) as? ProductsCell else {
                        fatalError("Expected ⁠ ProductsCell ⁠ type for reuseIdentifier \(ProductsCell.identifier).")
                    }

            let product = presenter?.product(indexPath.row)
            
            cell.configure(with: product?.name ?? "000", price: product?.priceText ?? "000", attribute: product?.attribute ?? "", image: (product?.imageURL)!, number: presenter.getCartItemNumber(index: indexPath.row))
            cell.backgroundColor = .white
            cell.delegate = self
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func didTapIncreaseButton(cell: ProductsCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        guard let data = presenter.product(indexPath.row) else {
            return
        }
        presenter.increaseProductCount(product: data)
    }
    
    func didTapDecreaseButton(cell: ProductsCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        guard let data = presenter.product(indexPath.row) else {
            return
        }
        presenter.decreaseProductCount(product: data)
    }
    func didTapIncreaseButton(cell: ProductsCellHorizontal) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        guard let data = presenter.product(indexPath.row) else {
            return
        }
        presenter.increaseProductCount(product: data)
    }
    
    func didTapDecreaseButton(cell: ProductsCellHorizontal) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        guard let data = presenter.product(indexPath.row) else {
            return
        }
        presenter.decreaseProductCount(product: data)
    }
    
}



extension ProductListView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 3
        return CGSize(width: width, height: 164.67)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
