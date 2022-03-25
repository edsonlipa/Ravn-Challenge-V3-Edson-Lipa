//
//  String+Extension.swift
//  Pokedex
//
//  Created by Edson Lipa on 25/03/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
