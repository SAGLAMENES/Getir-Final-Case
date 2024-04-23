//
//  ButtonExtension.swift
//  GetirFinalApp
//
//  Created by Enes Saglam on 21.04.2024.
//

import UIKit

extension UIButton {
    func plusButtonStyle() {
        
        let imageView = UIImageView(image: UIImage(named: "plus"))
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true // Adjust as needed
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        imageView.clipsToBounds = true //
    }
    
    
    func buttonStyle(name: String) {
        
        let imageView = UIImageView(image: UIImage(systemName: name))
        imageView.contentMode = .scaleToFill
        imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 22)
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true // Adjust as needed
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        imageView.layer.cornerRadius = 5
        
        
  
        
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        imageView.clipsToBounds = true //
    }
}
