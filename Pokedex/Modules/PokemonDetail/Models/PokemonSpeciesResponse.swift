//
//  PokeApiResponse.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation

struct PokemonSpeciesResponse: Codable, Identifiable {
    struct Color: Codable, Equatable {
        let name: String
        let url: String
    }
    
    struct EvolutionChain: Codable, Equatable {
        let url: String
    }
    
    struct FlavorTextEntry: Codable, Equatable {
        struct Language: Codable, Equatable {
            let name: String
            let url: String
        }
        
        struct Version: Codable, Equatable {
            let name: String
            let url: String
        }
        
        let flavorText: String
        let language: Language
        let version: Version
    }
    
    let id: Int
    let name: String
    let isLegendary: Bool
    let color: Color
    let evolutionChain: EvolutionChain
    let flavorTextEntries: [FlavorTextEntry]
}



