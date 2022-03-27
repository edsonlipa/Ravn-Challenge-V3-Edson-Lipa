//
//  PokemonEvolutionResponse.swift
//  Pokedex
//
//  Created by Edson Lipa on 26/03/22.
//

import Foundation

struct PokemonEvolutionResponse: Codable {
    struct Species: Codable {
        let name: String
    }
    
    struct ChainLink: Codable {
        let species: Species
        let evolvesTo: [ChainLink]
    }
    
    let chain: ChainLink
    let id: Int
    
}
