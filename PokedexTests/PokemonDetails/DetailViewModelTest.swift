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
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1.5)

        //Then
        XCTAssertFalse( detailViewModel.isLoading)
        XCTAssertEqual( detailViewModel.sprite, "image1")

        XCTAssertEqual( detailViewModel.pokemonModel.id , 1)
        XCTAssertEqual( detailViewModel.pokemonModel.name , "pikachu")
        XCTAssertEqual( detailViewModel.pokemonModel.isLegendary , true)
        XCTAssertFalse( detailViewModel.evolutions.isEmpty)
        XCTAssertFalse( detailViewModel.pokemonName == detailViewModel.pokemonModel.name)

        //When
        detailViewModel.spriteIndex = 1
        //Then
        XCTAssertEqual( detailViewModel.sprite, "image2")

    }
    
    func testPokeApiServicePokemonError() throws {
        //Given
        let service = PokeApiServiceMock(ServicePokemonResult: .failure)
        let detailViewModel = PokemonDetailViewModel(service: service)
        
        //When
        detailViewModel.getPokemon(id: 1)
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1.5)

        //Then
        XCTAssertTrue(detailViewModel.showErrorMessage)
        XCTAssertTrue(detailViewModel.showAlert)

    }
    
    func testPokeApiServiceSpeciesError() throws {
        //Given
        let service = PokeApiServiceMock(ServiceSpeciesResult: .failure)
        let detailViewModel = PokemonDetailViewModel(service: service)
        
        //When
        detailViewModel.getPokemon(id: 1)
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1.5)

        //Then
        XCTAssertTrue(detailViewModel.showErrorMessage)
        XCTAssertTrue(detailViewModel.showAlert)

    }
    
    func testPokeApiServiceEvolutionError() throws {
        //Given
        let service = PokeApiServiceMock(ServiceEvolutionResult: .failure)
        let detailViewModel = PokemonDetailViewModel(service: service)
        
        //When
        detailViewModel.getPokemon(id: 1)
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1.5)

        //Then
        XCTAssertTrue(detailViewModel.showErrorMessage)
        XCTAssertTrue(detailViewModel.showAlert)

    }

}
