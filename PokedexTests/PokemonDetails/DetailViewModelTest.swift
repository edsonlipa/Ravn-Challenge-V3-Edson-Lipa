//
//  DetailViewModelTest.swift
//  PokedexTests
//
//  Created by Edson Lipa on 27/03/22.
//

import XCTest
@testable import Pokedex

class DetailViewModelTest: XCTestCase {


    func testInitialViewModel() throws {
        //Given
        let service = PokeApiServiceMock()
        let detailViewModel = PokemonDetailViewModel(service: service)
        
        //When
        detailViewModel.getPokemon(id: 1)
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)

        //Then
        //XCTAssertFalse( listViewModel.pokemonModel.name == "Pokemon Name")
        XCTAssertEqual( detailViewModel.pokemonModel.id , 1)
        XCTAssertEqual( detailViewModel.pokemonModel.name , "pikachu")
        XCTAssertEqual( detailViewModel.pokemonModel.isLegendary , true)

    }
    
    func testPokeApiServiceError() throws {
        //Given
        let service = PokeApiServiceMock(ServiceResult: .failure)
        let detailViewModel = PokemonDetailViewModel(service: service)
        
        //When
        detailViewModel.getPokemon(id: 1)
        
        //Then
    }

}
