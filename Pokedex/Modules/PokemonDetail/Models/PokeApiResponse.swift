//
//  PokeApiResponse.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation

struct PokeApiResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let base_experience: Int
    let height: Int
    let is_default: Bool
    let order: Int
    let weight: Int
}
