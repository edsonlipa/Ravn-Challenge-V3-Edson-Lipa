//
//  GraphQLApiService.swift
//  Pokedex
//
//  Created by Edson Lipa on 25/03/22.
//

import Foundation
import Combine
import Apollo

typealias Pokemon = PokemonsQuery.Data.Pokemon

protocol GraphQLPokemonApiServiceType {
    func execute<T: GraphQLQuery>(for query: T) -> AnyPublisher<T.Data, Error>
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error>
}

struct GraphQLPokemonApiService: GraphQLPokemonApiServiceType {

    struct ApolloError: Error {
        let description: String
    }

    // MARK: - Variables Declaration
    private let client: ApolloClient

    // MARK: - Initilizers
    init(
        client: ApolloClient = ApolloClient(url: URL(string: "https://graphql-pokemon2.vercel.app")!)
    ) {
        self.client = client
    }

    // MARK: - Implementation
    func fetchPokemons() -> AnyPublisher<Array<Pokemon>, Error> {
                
        self.execute(for: PokemonsQuery(first: 850))
            .compactMap { $0.pokemons?.compactMap { $0 } }
            .eraseToAnyPublisher()
    }
    
    internal func execute<T>(for query: T) -> AnyPublisher<T.Data, Error> where T: GraphQLQuery {
        Future<T.Data, Error> { [weak client] promise in
            client?.fetch(query: query) { result in
                switch result {
                case let .success(queryResult):
                    if let data = queryResult.data {
                        promise(.success(data))
                    } else if let errors = queryResult.errors {
                        let error = errors.map { $0.localizedDescription }.joined(separator: "\n")
                        promise(.failure(ApolloError(description: error)))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

