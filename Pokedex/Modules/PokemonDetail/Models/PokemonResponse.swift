//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Edson Lipa on 25/03/22.
//

import Foundation

class PokemonResponse: Codable, Identifiable {
    struct Sprites: Codable{
        let frontDefault: String
        let frontShiny: String
    }
    
    struct TypesResponse: Codable {
        let slot: Int
        let type: TypeResponse
    }
    
    struct TypeResponse: Codable {
        let name: String
        let url: String
    }
    
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypesResponse]
    
    
}
