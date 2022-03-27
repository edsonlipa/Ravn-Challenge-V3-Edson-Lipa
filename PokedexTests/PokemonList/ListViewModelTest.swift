//
//  ListViewModelTest.swift
//  PokedexTests
//
//  Created by Edson Lipa on 26/03/22.
//

import XCTest
@testable import Pokedex

class ListViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewModel() throws {
        //Given
        let service = PokemonListServiceMock()
        let listViewModel = PokemonListViewModel(service: service)
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)

        //Then
        XCTAssertFalse( listViewModel.pokemonsFiltered.isEmpty)
        XCTAssertEqual( listViewModel.pokemonsFiltered.count, 4)

    }
    
    func testGroupedPokemons() throws {
        //Given 4 pokemons by mock service
        let service = PokemonListServiceMock()
        let listViewModel = PokemonListViewModel(service: service)
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)

        //Then
        XCTAssertEqual( listViewModel.pokemonsGrouped.count,2)

        XCTAssertEqual( listViewModel.pokemonsGrouped["Class 1"]?.count, 3)
    }
    
    func testSearchPokemons() throws {
        //Given
        let service = PokemonListServiceMock()
        let listViewModel = PokemonListViewModel(service: service)
        //When have 3 pokemons in 3 clsifications
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)

        listViewModel.textToSearch = "pika"
        //Then
        XCTAssertEqual( listViewModel.pokemonsGrouped.count, 1)
        XCTAssertEqual( listViewModel.pokemonClassifications.count, 1)

        XCTAssertEqual( listViewModel.pokemonsFiltered.count, 1)
        
        //When
        listViewModel.textToSearch = ""
        //Then
        XCTAssertEqual( listViewModel.pokemonsGrouped.count, 2)
        XCTAssertEqual( listViewModel.pokemonClassifications.count, 2)

        XCTAssertEqual( listViewModel.pokemonsFiltered.count, 4)

    }
    
    func testServiceError() throws {
        //Given
        let service = PokemonListServiceMock(ServiceResult: .failure)
        let listViewModel = PokemonListViewModel(service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)
        //Then

        XCTAssertTrue(listViewModel.showAlert)
        XCTAssertTrue(listViewModel.showErrorMessage)
    }
    
}
