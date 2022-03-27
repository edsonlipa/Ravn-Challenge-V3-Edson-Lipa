//
//  PokemonEvolutionCell.swift
//  Pokedex
//
//  Created by Edson Lipa on 26/03/22.
//

import Foundation

struct PokemonEvolutionCell: Identifiable {
    let firt: PokemonEvolution
    let second: PokemonEvolution
    var id: String {
        second.name
    }
}

struct PokemonEvolution {
    let id: Int
    let name: String
    let shape: String
}
