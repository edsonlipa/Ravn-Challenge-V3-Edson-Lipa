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

    var ServiceResult: PokeApiMuckResult = .success
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
            frontDefault: "image 1",
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
            species: PokemonEvolutionResponse.Species(name: "pokemon name"),
            evolvesTo: []),
        id: 1)

    
    func fetchPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        return ServiceResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonSpeciesResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        return ServiceResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemonEvolutions(stringURL: String) -> AnyPublisher<PokemonEvolutionResponse, Error> {
        return ServiceResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonEvolutionResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func fetchPokemon(name: String) -> AnyPublisher<PokemonResponse, Error> {
        return ServiceResult == .failure
            ? Fail(error: NSError())
                .eraseToAnyPublisher()
            : Just(pokemonResponse)
                .setFailureType(to: Error.self)
                .delay(for: ServiceResult == .delayed
                             ? .seconds(1)
                             : .milliseconds(1) ,
                            scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    
}

