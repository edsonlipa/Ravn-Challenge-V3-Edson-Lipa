//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import Foundation
import Apollo

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = [PokemonListItem]()
    @Published var textToSearch: String = ""
    @Published var isLoading = false

    var pokemonsFiltered: [PokemonListItem] {
        return textToSearch == "" ? pokemonList : pokemonList.filter{ $0.name.lowercased().contains(textToSearch.lowercased())}
    }
    
    init() {
//        pokemonList = [PokemonListItem(id: 1, defaultFrontalSprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", name: "pokemon name", types: "water")]
        getallPokemons()
    }
    
    func getallPokemons() {
        //let allPokemons =
        Network.shared.apollo.fetch(query: AllPokemonQuery()) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Something bad happened \(error)")

            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.allPokemon else { return }
                //print(data)
                self?.pokemonList = data.map{
                    let types = $0?.types?.map{ type in
                        PokemonType(id: Int(type?.id ?? 0), name: type?.name)
                    }
                    
                    return PokemonListItem(
                        id: Int($0?.id ?? 0),
                        defaultFrontalSprite: $0?.sprites?.frontDefault,
                        name: $0?.name,
                        types: types)
                    
                }
            }
        }        
    }
}
