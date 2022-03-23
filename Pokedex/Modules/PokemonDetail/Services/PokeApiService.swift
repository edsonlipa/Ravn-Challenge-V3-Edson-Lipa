//
//  PokeApiService.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import Combine

protocol PokeApiServiceType {
    func fetcPokemon(id: Int) -> AnyPublisher<PokeApiResponse, Error>
}

struct PokeApiService: PokeApiServiceType {
    let baseURL = "https://pokeapi.co/api/v2"
    let decoder: JSONDecoder
    let session: URLSession

    init(
        decoder: JSONDecoder = JSONDecoder(),
        session: URLSession = .shared
    ) {
        self.decoder = decoder
        self.session = session
    }
    
    func fetcPokemon(id: Int) -> AnyPublisher<PokeApiResponse, Error> {
        let finalURL = baseURL + "/pokemon/?id=\(id)"

        return session
            .dataTaskPublisher(for: URL(string: finalURL)!)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    print("badServerResponse")
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PokeApiResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
}
