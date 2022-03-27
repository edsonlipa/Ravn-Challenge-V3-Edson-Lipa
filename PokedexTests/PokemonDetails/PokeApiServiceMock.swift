//
//  PokeApiServiceMock.swift
//  PokedexTests
//
//  Created by Edson Lipa on 27/03/22.
//

import Foundation
import Combine
@testable import Pokedex

enum PokeApiMuckResult {
    case success
    case failure
    case delayed
}

struct PokeApiServiceMock: PokeApiServiceType {
    var ServiceSpeciesResult: PokeApiMuckResult = .success
    var ServicePokemonResult: PokeApiMuckResult = .success
    var ServiceEvolutionResult: PokeApiMuckResult = .success

    var pokemonSpeciesResponse = PokemonSpeciesResponse(
        id: 1,
        name: "pikachu",
        isLegendary: true,
        color: PokemonSpeciesResponse.Color(name: "Red", url: "url"),
        generation: PokemonSpeciesResponse.Generation(name: "gen 1"),
        evolutionChain: PokemonSpeciesResponse.EvolutionChain(url: "evolution url"),
        flavorTextEntries: [PokemonSpeciesResponse.FlavorTextEntry(
            flavorText: "description",
            language: PokemonSpeciesResponse.FlavorTextEntry.Language(
                name: "en",
                url: "url"),
            version: PokemonSpeciesResponse.FlavorTextEntry.Version(
                name: "",
                url: "url"))
                            ]
    )
    
    var pokemonResponse = PokemonResponse(
        id: 1,
        name: "pikachu",
        sprites: PokemonResponse.Sprites(
            frontDefault: "image1",
            frontShiny: "image2"),
        types: [PokemonResponse.TypesResponse(
            slot: 0,
            type: PokemonResponse.TypeResponse(
                name: "name",
                url: "url"))
               ]
    )
    
    var pokemonEvolutionResponse = PokemonEvolutionResponse(
        chain: PokemonEvolutionResponse.ChainLink(
            species: PokemonEvolutionResponse.Species(name: "pikachu"),
            evolvesTo: [PokemonEvolutionResponse.ChainLink(
                species: PokemonEvolutionResponse.Species(name: "raichu"),
                evolvesTo: [])
                       ]),
        id: 1)

    
    func fetchPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        return ServiceSpeciesResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonSpeciesResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceSpeciesResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        return ServicePokemonResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServicePokemonResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemonEvolutions(stringURL: String) -> AnyPublisher<PokemonEvolutionResponse, Error> {
        return ServiceEvolutionResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonEvolutionResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceEvolutionResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemon(name: String) -> AnyPublisher<PokemonResponse, Error> {
        return ServicePokemonResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServicePokemonResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    
}

