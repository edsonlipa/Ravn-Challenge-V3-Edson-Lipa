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
    @Published var spriteIndex = 0
    @Published var showAlert = false
    @Published var showErrorMessage = false

    private var cancellables = Set<AnyCancellable>()
    private let service: PokeApiServiceType
    private var isSpeciesLoading = false
    private var isPokemonLoading = false
    private var isEvolutionLoading = false

    let getPokemonSpeciesRequest = PassthroughSubject<Void, Never>()
    let getPokemonRequest = PassthroughSubject<Void, Never>()

    let didThrowError = PassthroughSubject<Void, Never>()
    
    var isLoading: Bool {
        isSpeciesLoading || isPokemonLoading
    }
    
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
    }
    
    private func setPokemonSpeciesSubscriptions() {
        let result = getPokemonSpeciesRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isSpeciesLoading = true
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
                self?.isSpeciesLoading = false
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
//                self?.isLoading = false
                self?.getPokemonRequest.send()

                self?.pokemonModel.id = response.id
                self?.pokemonModel.generation = response.generation.name.capitalized
                self?.pokemonModel.description = response.flavorTextEntries[0].flavorText
                if let textEntry=response.flavorTextEntries.first(where: {$0.language.name == "en"}){
                    let flavorText = textEntry.flavorText.filter{!"\n".contains($0)}
                    self?.pokemonModel.description = flavorText
                }
                self?.pokemonModel.backgroundColor = response.color.name
                self?.pokemonModel.isLegendary = response.isLegendary
                
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
    
    private func setPokemonSubscriptions() {
        let result = getPokemonRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isPokemonLoading = true
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
                self?.isPokemonLoading = false
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
                self?.showAlert = true
                self?.showErrorMessage = true
            }
            .store(in: &cancellables)
    }
}
