//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    var id: Int
    var detailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        Text("hello \(id)")
            .onAppear{
                detailViewModel.getPokemon(id: id)
            }
    }
}
