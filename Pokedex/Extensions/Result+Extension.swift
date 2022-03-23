//
//  Result+Extension.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation

extension Result {
    var isSuccessful: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
