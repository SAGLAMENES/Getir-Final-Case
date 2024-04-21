//
//  ButtonExtension.swift
//  GetirFinalApp
//
//  Created by Enes Saglam on 21.04.2024.
//

import UIKit

extension UIButton {
    func applyCustomStyle() {
        // Set button width and height constraints
        
        let imageView = UIImageView(image: UIImage(named: "plus"))
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        // Set image view constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true // Adjust as needed
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        imageView.clipsToBounds = true //
        
        
    }
}
