//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import SwiftUI

struct PokemonDetailView: View {
    var id: Int
    @ObservedObject var detailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack{
            //image section
                // button section
            //data section
                //id name
                //types
                //generation
                //description
            //evolution section
                //evolution cell
        }
        Text("hello \(detailViewModel.pokemonModel.id)")
        
            .onAppear{
                detailViewModel.getPokemon(id: id)
            }
    }
}


struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(id: 5)
    }
}
