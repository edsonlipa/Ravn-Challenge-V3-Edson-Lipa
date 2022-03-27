//
//  PokemonListServiceMock.swift
//  PokedexTests
//
//  Created by Edson Lipa on 26/03/22.
//

import Foundation
import Combine
@testable import Pokedex

typealias Pokemon = PokemonsQuery.Data.Pokemon

enum PokemonListMuckResult {
    case success
    case failure
    case delayed
}

struct PokemonListServiceMock: GraphQLPokemonApiServiceType {
    var ServiceResult: PokemonListMuckResult = .success
    var pokemons = [
        Pokemon(id: "0", number: "001", name: "pikachu", classification: "Class 1", types: ["type1"], image: "image"),
        Pokemon(id: "1", number: "002", name: "bulvasor",  classification: "Class 1", types: ["type1"], image: "image"),
        Pokemon(id: "2", number: "003", name: "charizar",  classification: "Class 1", types: ["type1"], image: "image"),
        Pokemon(id: "3", number: "004", name: "vaporeon", classification: "Class 2", types: ["type1"], image: "image"),

        
    ]
    
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error> {
        return ServiceResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemons)
                .setFailureType(to: Error.self)
                .delay(for: ServiceResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
}

