//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Edson Lipa on 23/03/22.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    //@Published var pokemonModel: PokemonDetail

    //Input
    let getPokemonRequest = PassthroughSubject<Void, Never>()
    var id: Int = 0
    private var cancellables = Set<AnyCancellable>()
    private let service: PokeApiServiceType
    @Published var isLoading = false
    let didThrowError = PassthroughSubject<Void, Never>()

    init(service: PokeApiServiceType = PokeApiService()) {
        self.service = service
        setSubscriptions()
    }
    
    func getPokemon(id: Int) {
        self.id = id
        self.getPokemonRequest.send()
    }
    
    private func setSubscriptions() {
        let result = getPokemonRequest
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .map { [service, weak self] _ -> AnyPublisher<Result<PokeApiResponse, Error>, Never> in
                service.fetcPokemon(id: self?.id ?? 0)
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
            .compactMap { result -> PokeApiResponse? in
                switch result {
                case .success(let response):
                    return response
                default:
                    return nil
                }
            }
            .sink { [weak self] response in
                print(response)
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
