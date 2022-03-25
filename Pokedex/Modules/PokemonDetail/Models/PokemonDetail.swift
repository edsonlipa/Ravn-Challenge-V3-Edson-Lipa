//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation

struct PokemonDetail {
    let id: Int
    let name: String
    let types: [PokemonType]
    let generation: String
    let description: String
    let defaultSprite: String
    let shinySprite: String
}
