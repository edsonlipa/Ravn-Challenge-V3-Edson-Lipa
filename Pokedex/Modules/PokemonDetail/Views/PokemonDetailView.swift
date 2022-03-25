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
    
//    private let barTitle = "pokemonDetail.bar.title".localized()
//    private let defaultText = "pokemonDetail.defaultSprite.text".localized()
//    private let shinyText = "pokemonDetail.shinySprite.text".localized()
    
    private func PokemonDetailHeader() -> some View {
        ZStack {
            Rectangle()
                .fill(Color(detailViewModel.pokemonModel.backgroundColor.capitalizingFirstLetter()))
            
            VStack {
                KFImage(URL(string: detailViewModel.sprite))
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
        }
        .frame(height: 256)

    }
    
    private func PokemonDetailInformation() -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.white)
            VStack {
                //Text(detailViewModel.pokemonModel.name)
                Text(String(format: "#%03d \(detailViewModel.pokemonName)", id))
//                    .padding(.top, 16.0)
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
    
    var body: some View {
        VStack{
            PokemonDetailHeader()
            PokemonDetailInformation()
            //data section
                //id name
                //types
                //generation
                //description
            //evolution section
                //evolution cell
        }
//        Text("hello \(detailViewModel.pokemonModel.id)")
        .navigationTitle("Pokemon Info")
        .navigationBarTitleDisplayMode(.inline)
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
