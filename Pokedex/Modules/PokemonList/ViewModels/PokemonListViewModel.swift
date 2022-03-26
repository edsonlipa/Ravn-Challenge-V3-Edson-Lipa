//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import Foundation
import Apollo
import Combine


class PokemonListViewModel: ObservableObject {
    typealias Pokemon = PokemonsQuery.Data.Pokemon

    @Published var pokemonList: [PokemonListItem] = [PokemonListItem]()
    @Published var textToSearch: String = ""
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var showErrorMessage = false
    
    let getPokemonRequest = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    private let service: GraphQLPokemonApiServiceType
    
    var pokemonsFiltered: [PokemonListItem] {
        textToSearch.isEmpty
        ? pokemonList
        : pokemonList.filter{
            $0.name.lowercased().contains(
                textToSearch.lowercased()
            )}
    }
    
    var pokemonsGrouped: [String: [PokemonListItem]] {
        Dictionary(grouping: pokemonsFiltered) {
            $0.classification
        }
    }
    
    var pokemonClassifications: [String] {
        pokemonsGrouped.keys.sorted(by: <).map { String($0) }
    }
    
    init(service: GraphQLPokemonApiServiceType = GraphQLPokemonApiService()) {
        self.service = service
        setAllPokemonsSuscription()
        getPokemonRequest.send()
    }
    
    func setAllPokemonsSuscription() {
        let result = getPokemonRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .map { [service] _ -> AnyPublisher<Result<Array<Pokemon>, Error>, Never> in
                service.fetchPokemons()
                    .map { .success($0) }
                    .catch { Just(.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .share()
        
        result
            .filter { $0.isSuccessful }
            .compactMap { result -> Array<Pokemon>? in
                switch result {
                case .success(let response):
                    return response
                default:
                    print("super error")
                    return nil
                }
            }
            .sink { [weak self] response in
                self?.pokemonList = response.map{ pokemon in
                  
                    return PokemonListItem(
                        id: Int(pokemon.number ?? "-1") ?? -1,
                        defaultFrontalSprite: pokemon.image ?? "Pokeball",
                        name: pokemon.name ?? "Pokemon Name",
                        types: pokemon.types?.filter{ $0 != nil }.map{ $0! } ?? ["Type"],
                        classification: pokemon.classification ?? "Classification"
                    )
                }
            }
            .store(in: &cancellables)
        
        result
            .filter { !$0.isSuccessful }
            .sink { [weak self] error in
                self?.showAlert = true
                self?.showErrorMessage = true
            }
            .store(in: &cancellables)
    }
}
