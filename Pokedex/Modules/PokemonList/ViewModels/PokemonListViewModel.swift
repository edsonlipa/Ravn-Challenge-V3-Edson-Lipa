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
    var pokemonsFiltered: [PokemonListItem] {
        return textToSearch == "" ? pokemonList : pokemonList.filter{ $0.name.lowercased().contains(textToSearch.lowercased())}
    }
    
    init() {
        getallPokemons()
    }
    
    func getallPokemons() {
//        let graphQLClient = ApolloClient(url: URL(string: "http://localhost:8080/graphql")!)
        let allPokemons = Network.shared.apollo.fetch(query: AllPokemonQuery(limit: 5)) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Something bad happened \(error)")

            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.allPokemon else { return }
                self?.pokemonList = data.map{ PokemonListItem(id: Int($0?.id ?? 0), defaultFrontalSprite: $0?.sprites?.frontDefault, name: $0?.name, types: "Agua")}
            }
        }

    }
}
