//
//  ContentView.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var listViewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List(listViewModel.pokemonsFiltered) { item in
                //NavigationLink(destination: EmptyView()) {
                    PokemonListItemView(item: item)
                    .frame(height: 80)
                //}
                .listRowBackground(Color(UIColor.systemGray6))
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            }
            .navigationTitle("Pokémon List")
        }
        .searchable(
            text: $listViewModel.textToSearch,
            placement: .navigationBarDrawer(displayMode: .always))
    }
}



struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
