//
//  PokemonListItemView.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct PokemonListCellView: View {
    let item: PokemonListItem
    
//    private func sectionHeader(title: String) -> some View {
//        VStack(alignment: .leading, spacing: .zero) {
//            Text(title)
//                .font(.title3)
//                .padding(.top, 10)
//
//            Rectangle()
//                .fill(color)
//                .frame(height: width)
//                .edgesIgnoringSafeArea(.horizontal)
//        }
//        //.customRowStyle()
//    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .cornerRadius(15)
                .offset(x: 24, y: 0)
                .padding(.trailing, 24)
                //.frame(height: 80)
            HStack {
                KFImage(URL(string: item.defaultFrontalSprite))
                        .placeholder{
                            Image("Pokeball Grey")
                                .resizable()
                                .scaledToFit()
                        }
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
               
                VStack(alignment: .leading) {
                    Text((item.name?.capitalizingFirstLetter()) ?? item.name)
                        .font(Font.custom("SF Pro Text", size: 17))
                    Text(String(format: "#%03d", item.id))
                }
                Spacer()
                HStack {
                    ForEach(item.types) { name in
                        Image("Types/\(name)")
                    }
                }
                
            }
        }
        .overlay( NavigationLink(destination: PokemonDetailView(id: item.id), label: {
            EmptyView()
        }))
    }
}

struct PokemonListCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListCellView(item: PokemonListItem(id: 0, defaultFrontalSprite: "image", name: "name", types: ["Water"], classification: "algo"))
    }
}
