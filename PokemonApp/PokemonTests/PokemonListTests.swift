//
//  PokemonListTests.swift
//  PokemonTests
//
//  Created by Elijah Chan on 3/10/23.
//

import XCTest

final class PokemonListTests: XCTestCase, PokemonListDelegate {
    let mockPokemonListVM = PokemonListViewModel(dataSource: MockRemotePokemonDataSource.shared)
    let mockOffset = 0
    let mockLimit = 100
    var expectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPokemonListViewModel() {
        expectation = expectation(description: "PokemonList")
        mockPokemonListVM.limit = mockLimit
        mockPokemonListVM.delegate = self
        mockPokemonListVM.fetchMorePokemon()
        waitForExpectations(timeout: 100)
    }
    
    func reloadTable() {
        XCTAssert(mockPokemonListVM.pokemon.count == mockLimit)
        for result in mockPokemonListVM.pokemon {
            XCTAssert(result.name != "")
            XCTAssert(result.url != URL(string: "") ?? nil)
        }
        expectation.fulfill()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
