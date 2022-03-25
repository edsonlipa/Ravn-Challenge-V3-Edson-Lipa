//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import SwiftUI

struct PokemonDetail: Codable {
    struct PokemonType: Codable, Identifiable {
        var id: String { self.name }
        var name: String
    }

    var id: Int
    var name: String
    var types: [PokemonType]
    var backgroundColor: String
    var generation: String
    var description: String
    var defaultSprite: String
    var shinySprite: String
    var isLegendary: Bool
}
