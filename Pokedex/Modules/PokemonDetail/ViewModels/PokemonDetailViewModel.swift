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
    @Published var stringUrl: String = ""
    @Published var pokemonModel: PokemonDetail
    @Published var spriteIndex = 0
    @Published var showAlert = false
    @Published var showErrorMessage = false
    @Published var evolutions = [PokemonEvolutionCell]()

    private var cancellables = Set<AnyCancellable>()
    private let service: PokeApiServiceType
    private var isSpeciesLoading = false
    private var isPokemonLoading = false
    private var isEvolutionLoading = false

    let getPokemonSpeciesRequest = PassthroughSubject<Void, Never>()
    let getPokemonRequest = PassthroughSubject<Void, Never>()
    let getPokemonEvolutionsRequest = PassthroughSubject<String, Never>()
    let getPokemonByNameRequest = PassthroughSubject<String, Never>()

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
            isLegendary: false,
            evolutionChain: "https://pokeapi.co/api/v2/evolution-chain/73"
        )
        
        setPokemonSpeciesSubscriptions()
        setPokemonSubscriptions()
        setPokemonEvolutionsSubscriptions()
        setPokemonNameSubscriptions()
    }
    
    func getPokemon(id: Int) {
        self.id = id
        self.getPokemonSpeciesRequest.send()
    }
    
    func getEvolutions(stringUrl: String ) {
        self.stringUrl = stringUrl
        getPokemonEvolutionsRequest.send(stringUrl)
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
                self?.pokemonModel.evolutionChain = response.evolutionChain.url
        
                self?.getEvolutions(stringUrl: response.evolutionChain.url)
                
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
    
    private func setPokemonEvolutionsSubscriptions() {
        let result = getPokemonEvolutionsRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isEvolutionLoading = true
            })
            .map { [service] value -> AnyPublisher<Result<PokemonEvolutionResponse, Error>, Never> in
                return service.fetchPokemonEvolutions(stringURL: value)
                    .map { .success($0) }
                    .catch { Just(.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isEvolutionLoading = false

            })
            .share()
        
        result
            .filter { $0.isSuccessful }
            .compactMap { result -> PokemonEvolutionResponse? in
                switch result {
                case .success(let response):
                    return response
                default:
                    return nil
                }
            }
            .sink { [weak self] response in
                self?.evolutions = [PokemonEvolutionCell]()
                var evolveFrom: PokemonEvolutionResponse.ChainLink = response.chain
                while !evolveFrom.evolvesTo.isEmpty {
                    if  evolveFrom.species.name == self?.pokemonModel.name {
                        print( "Exito \(evolveFrom.species.name )"    )

                        evolveFrom.evolvesTo.forEach{ evolution in
                            print(evolution.species.name)
                            self?.getPokemonByNameRequest.send(evolution.species.name)
                        }
                        break
                    }
                    evolveFrom = evolveFrom.evolvesTo[0]

                }
                
            }
            .store(in: &cancellables)

        result
            .filter { !$0.isSuccessful }
            .sink { [weak self] error in
                self?.showAlert = true
                self?.showErrorMessage = true
                print("Error!!")
            }
            .store(in: &cancellables)
    }

    private func setPokemonNameSubscriptions() {
        let result = getPokemonByNameRequest
            .map { [service] name -> AnyPublisher<Result<PokemonResponse, Error>, Never> in
                service.fetchPokemon(name: name)
                    .map { .success($0) }
                    .catch { Just(.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)

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
                guard let self = self else {
                    return                }
                let evolutionTo = PokemonEvolution(id: response.id, name: response.name, shape: response.sprites.frontDefault)
                let evolutionfrom = PokemonEvolution(id: self.pokemonModel.id, name:  self.pokemonModel.name, shape:  self.pokemonModel.defaultSprite)
                self.evolutions.append(PokemonEvolutionCell(firt: evolutionfrom, second: evolutionTo))
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
