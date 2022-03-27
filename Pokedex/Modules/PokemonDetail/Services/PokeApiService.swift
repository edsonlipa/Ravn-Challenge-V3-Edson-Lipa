//
//  PokeApiService.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import Combine
import SwiftUI

protocol PokeApiServiceType {
    func fetchPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error>
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error>
    func fetchPokemonEvolutions(stringURL: String) -> AnyPublisher<PokemonEvolutionResponse, Error>
    func fetchPokemon(name: String) -> AnyPublisher<PokemonResponse, Error>
}

struct PokeApiService: PokeApiServiceType {

    let baseURL = "https://pokeapi.co/api/v2"
    let decoder: JSONDecoder
    let session: URLSession

    init(
        decoder: JSONDecoder = JSONDecoder(),
        session: URLSession = .shared
    ) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
        self.session = session
    }
    

    
    func fetchPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        let finalURL = baseURL + "/pokemon-species/\(id)"

        return execute(for: URL(string: finalURL)!)
            .decode(type: PokemonSpeciesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        let finalURL = baseURL + "/pokemon/\(id)"

        return execute(for: URL(string: finalURL)!)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    func fetchPokemon(name: String) -> AnyPublisher<PokemonResponse, Error> {
        let finalURL = baseURL + "/pokemon/\(name)"

        return execute(for: URL(string: finalURL)!)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func fetchPokemonEvolutions(stringURL: String) -> AnyPublisher<PokemonEvolutionResponse, Error> {
        print(stringURL)
        return execute(for: URL(string: stringURL)!)
            .decode(type: PokemonEvolutionResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
        
    }

}

extension PokeApiService {
    func execute(for url: URL) -> AnyPublisher<Data, Error> {
        session
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    print("badServerResponse")
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .eraseToAnyPublisher()
    }
}
