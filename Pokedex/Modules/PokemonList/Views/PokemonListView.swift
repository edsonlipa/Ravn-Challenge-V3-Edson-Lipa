//
//  ContentView.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var listViewModel = PokemonListViewModel()
    @State private var navigate = false
    @State private var id = 0

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(listViewModel.pokemonClassifications, id: \.id) { classification in
                        VStack {
                            sectionHeader(classification: classification)
                            
                            ForEach(listViewModel.pokemonsGrouped[classification]
                                    ?? [PokemonListItem](), id: \.id) { item in
                                PokemonListCellView(item: item)
                                    .frame(height: 80)
                                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                                    .onTapGesture {
                                        navigate.toggle()
                                        self.id = item.id
                                    }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGray6))
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())

                }
                .navigationTitle("Pokémon List")
                .opacity(listViewModel.showAlert ? 0 : 1)
                
                NavigationLink(isActive: $navigate){
                    PokemonDetailView(id: id)
                } label: {
                    EmptyView()
                }
                .opacity(.zero)
                
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
    
    func sectionHeader(classification: String) -> some View {
        VStack(alignment: .leading) {
            Text(classification)
                .font(.system(size: 20))

            Rectangle()
                .fill(.black)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}



struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
