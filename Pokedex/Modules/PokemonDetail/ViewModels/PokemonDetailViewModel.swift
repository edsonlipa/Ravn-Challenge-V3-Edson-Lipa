//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var pokemonModel: PokemonDetail
    @Published var isLoading = false
    @Published var spriteIndex = 0

    private var cancellables = Set<AnyCancellable>()
    private let service: PokeApiServiceType

    let getPokemonSpeciesRequest = PassthroughSubject<Void, Never>()
    let getPokemonRequest = PassthroughSubject<Void, Never>()

    let didThrowError = PassthroughSubject<Void, Never>()
    
    var sprite: String {
        return spriteIndex == 0 ? pokemonModel.defaultSprite : pokemonModel.shinySprite
    }
    
    var pokemonName: String {
        pokemonModel.name.capitalizingFirstLetter()
    }

    init(service: PokeApiServiceType = PokeApiService()) {
        self.service = service
        pokemonModel = PokemonDetail(
            id: 999,
            name: "Pokemon Name",
            types: [],
            backgroundColor: "Black",
            generation: "Generation Pokemon",
            description: "description",
            defaultSprite: "defaultSprite url",
            shinySprite: "shinySprite url",
            isLegendary: false)
        
        setPokemonSpeciesSubscriptions()
        setPokemonSubscriptions()
    }
    
    func getPokemon(id: Int) {
        self.id = id
        self.getPokemonSpeciesRequest.send()
        self.getPokemonRequest.send()
    }
    
    private func setPokemonSpeciesSubscriptions() {
        let result = getPokemonSpeciesRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .map { [service, weak self] _ -> AnyPublisher<Result<PokemonSpeciesResponse, Error>, Never> in
                service.fetchPokemonSpecies(id: self?.id ?? 0)
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
            .compactMap { result -> PokemonSpeciesResponse? in
                switch result {
                case .success(let response):
                    return response
                default:
                    print("super error")
                    return nil
                }
            }
            .sink { [weak self] response in

//                let evolutionChain: EvolutionChain
                
                self?.pokemonModel.id = response.id
                self?.pokemonModel.generation = response.generation.name.capitalized
//                let test = String(text.filter { !" \n\t\r".contains($0) })
                self?.pokemonModel.description = response.flavorTextEntries[0].flavorText
//                if let flavor =
                if let textEntry=response.flavorTextEntries.first(where: {$0.language.name == "en"}){
                    let flavorText = textEntry.flavorText.filter{!"\n".contains($0)}
                    self?.pokemonModel.description = flavorText
                }
                    
                self?.pokemonModel.backgroundColor = response.color.name
                self?.pokemonModel.isLegendary = response.isLegendary
                //add description
            }
            .store(in: &cancellables)

        result
            .filter { !$0.isSuccessful }
            .sink { [weak self] error in
                print("error")
                self?.didThrowError.send()
            }
            .store(in: &cancellables)
    }
    
    private func setPokemonSubscriptions() {
        let result = getPokemonRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .map { [service, weak self] _ -> AnyPublisher<Result<PokemonResponse, Error>, Never> in
                service.fetchPokemon(id: self?.id ?? 0)
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
            .compactMap { result -> PokemonResponse? in
                switch result {
                case .success(let response):
                    return response
                default:
                    return nil
                }
            }
            .sink { [weak self] response in
//                print(response.types)
                self?.pokemonModel.id = response.id
                self?.pokemonModel.name = response.name
                self?.pokemonModel.defaultSprite = response.sprites.frontDefault
                self?.pokemonModel.shinySprite = response.sprites.frontShiny
                self?.pokemonModel.types = response.types.map{types in
                    PokemonDetail.PokemonType(
                        name: types.type.name.capitalizingFirstLetter()
                    )
                }
            }
            .store(in: &cancellables)

        result
            .filter { !$0.isSuccessful }
            .sink { [weak self] error in
                print("error")
                self?.didThrowError.send()
            }
            .store(in: &cancellables)
    }
}
