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
            List(listViewModel.pokemonList) { item in
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        AsyncImage(url: URL(string: item.defaultFrontalSprite)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        VStack {
                            Text(item.name)
                            Text(String(format: "#%03d", item.id))
                        }
                    }
                    .padding()
                }
                
            }
            .navigationTitle("Pokémon List")
        }
        .searchable(
            text: $listViewModel.textToSearch,
            placement: .navigationBarDrawer(displayMode: .always))
//        .onAppear {
//            listViewModel.getallPokemons()
//        }

    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
