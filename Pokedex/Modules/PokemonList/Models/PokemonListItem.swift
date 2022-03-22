//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import Foundation
struct PokemonListItem: Identifiable {
    var id: Int
    var defaultFrontalSprite: String!
    var name: String!
    var types: String!
}

//extension PokemonListItem {
//    init?(_ pokemon: AllPokemonQuery.Data.AllPokemon){
//        guard let userID = Int(pokemon.id!) else {
//              return nil
//            }
//        
//    }
//}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
