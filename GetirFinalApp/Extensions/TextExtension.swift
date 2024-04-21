//
//  TextExtension.swift
//  MVVM-C-Programmatic
//
//  Created by Enes Saglam on 20.04.2024.
//

import Foundation

extension String {
    func truncateToFourWords() -> String {
        // Split the string into words
        let words = self.components(separatedBy: .whitespacesAndNewlines)
        
        // Take only the first four words
        let truncatedWords = Array(words.prefix(5))
        
        // Join the words back into a string
        let truncatedString = truncatedWords.joined(separator: " ")
        
        return truncatedString
    }
}
