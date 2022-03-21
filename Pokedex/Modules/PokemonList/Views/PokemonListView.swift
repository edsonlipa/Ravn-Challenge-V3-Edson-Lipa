//
//  ContentView.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var allPokemons = ""
    
    var body: some View {

        HStack{
            Text("Pokemons")
//            ScrollView {
//                Network.shared.apollo.fetch(query: Pok) { result in
//                    switch result {
//                    case .success(let graphQLResult):
//                        if let
//                    }
//
//                }
//            }
        }
        
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
