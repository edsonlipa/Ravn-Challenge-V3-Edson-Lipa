//
//  ContentView.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonListView: View {
    @ObservedObject var listViewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(listViewModel.pokemonClassifications, id: \.id) { classification in
                        Section(content: {
                            ForEach(listViewModel.pokemonsGrouped[classification]
                                    ?? [PokemonListItem](), id: \.id) { item in
                                PokemonListCellView(item: item)
                                    .frame(height: 80)
                                    .listRowBackground(Color(UIColor.systemGray6))
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                            }
                        }, header: {
                            Text(classification)
                        })
                    }
                }
                .navigationTitle("Pokémon List")
                .opacity(listViewModel.showAlert ? 0 : 1)
                
                erroTextView()
                    .opacity(listViewModel.showErrorMessage ? 1 : 0)

                ProgressView( "Loading...")
                .frame(minWidth: 0, maxWidth: .infinity)
                .opacity(listViewModel.isLoading ? 1 : 0)
            }
            
        }
        .alert(isPresented: $listViewModel.showAlert) {
            Alert(
                title: Text("There was an Error"),
                message: Text("Failed to Load Data")
            )
        }
        .searchable(
            text: $listViewModel.textToSearch,
            placement: .navigationBarDrawer(displayMode: .always))
        
    }
    
    func erroTextView() -> some View {
        VStack {
            Text("Failed to Load Data")
                .frame(alignment: .top)
                .foregroundColor(.red)
            
            Spacer()
        }
    }
}



struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
