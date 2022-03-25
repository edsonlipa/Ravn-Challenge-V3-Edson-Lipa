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
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
               
                VStack(alignment: .leading) {
                    Text((item.name?.capitalizingFirstLetter()) ?? item.name)
                        .font(Font.custom("SF Pro Text", size: 17))
                    Text(String(format: "#%03d", item.id))
                }
                HStack {
                    ForEach(item.types) { type in
                        Text(type.name)
                    }
                }
            }
        }
        .overlay( NavigationLink(destination: PokemonDetailView(id: item.id), label: {
            EmptyView()
        }))
    }
}