//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    var id: Int
    @ObservedObject var detailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        ZStack {
            detailBodyView()
                .opacity(detailViewModel.isLoading || detailViewModel.showErrorMessage ? 0 : 1)
            
            ProgressView( "Loading...")
            .frame(minWidth: 0, maxWidth: .infinity)
            .opacity(detailViewModel.isLoading ? 1 : 0)
            
            erroTextView()
                .opacity(detailViewModel.showErrorMessage ? 1 : 0)
        }
        .onAppear{
            detailViewModel.getPokemon(id: id)
        }
        .alert(
            isPresented: $detailViewModel.showAlert
        ) {
            Alert(
                title: Text("There was an Error"),
                message: Text("Failed to Load Data")
            )
        }
        .navigationTitle("Pokemon Info")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func PokemonDetailHeader() -> some View {
        ZStack {
            
            Rectangle()
                .fill(Color(detailViewModel.pokemonModel.backgroundColor.capitalizingFirstLetter()))
            
            VStack {
                KFImage(URL(string: detailViewModel.sprite))
                    .placeholder{
                        Image("Pokeball Grey")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .resizable()
                    .frame(width: 158.4, height: 158.4)
                    .padding(.vertical, 4)

                Picker("", selection: $detailViewModel.spriteIndex) {
                    Text("defaultText")
                        .tag(0)
                        .font(.system(size: 15))

                    Text("shinyText")
                        .tag(1)
                        .font(.system(size: 15))

                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
            }
            HStack{
                Spacer()
                VStack{
                    Image("Legendary icon")
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                    Spacer()
                }
            }
            .opacity(detailViewModel.pokemonModel.isLegendary ? 1 : 0)
            
            
        }
        .frame(height: 256)

    }
    
    private func PokemonDetailInformation() -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.white)
            VStack {
                Text(String(format: "#%03d \(detailViewModel.pokemonName)", id))
                    .font(Font.system(size: 28))
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    
                HStack {
                    ForEach(detailViewModel.pokemonModel.types) { type in
                        Image("Tags/\(type.name)")
                            .padding(.top, 0)

                    }
                }
                .padding(.top, 0)

                Text(detailViewModel.pokemonModel.generation)
                    .font(Font.system(size: 17))
                    .padding(16)

                Text(detailViewModel.pokemonModel.description)
                    .padding(.top, 0)
                    .font(Font.system(size: 13))
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .cornerRadius(20)
        .offset(x: 0, y: -24)
    }
    
    private func evolutionView() -> some View {
        ScrollView{
            Text("Evolutions")
            LazyVStack{
                ForEach(detailViewModel.evolutions) { evolutionCell in
                    HStack {
                        HStack{
                            KFImage(URL(string: evolutionCell.firt.shape)!)
                            VStack{
                                Text(String(format: "#%03d",  evolutionCell.firt.id))
                                    .font(.system(size: 17))
                                Text(evolutionCell.firt.name)
                                    .font(.system(size: 17))
                            }
                        }
                        Text(">")
                        HStack{
                            KFImage(URL(string: evolutionCell.second.shape)!)
                            VStack(alignment: .leading){
                                Text(String(format: "#%03d",  evolutionCell.second.id))
                                    .font(.system(size: 17))
                                Text(evolutionCell.second.name)
                                    .font(.system(size: 17))
                            }
                        }
                    }
                }
            }
        }
        .opacity(detailViewModel.evolutions.isEmpty ? 0 : 1)
        
    }
    
    private func detailBodyView() -> some View {
        VStack{
            PokemonDetailHeader()
            PokemonDetailInformation()
            evolutionView()
            //PokemonEvolutionView(url: detailViewModel.pokemonModel.evolutionChain)

        }
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

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(id: 5)
    }
}
