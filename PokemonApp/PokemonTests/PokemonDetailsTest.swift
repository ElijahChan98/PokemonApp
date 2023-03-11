//
//  PokemonDetailsTest.swift
//  PokemonTests
//
//  Created by Elijah Chan on 3/11/23.
//

import XCTest

final class PokemonDetailsTest: XCTestCase, PokemonDetailsDelegate {
    let mockId = "1"
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
    
    func testPokemonDetailsViewModel() {
        expectation = expectation(description: "PokemonDetails")
        let mockPokemonDetailsVM = PokemonDetailsViewModel(id: mockId, dataSource: MockRemotePokemonDataSource.shared)
        mockPokemonDetailsVM.delegate = self
        mockPokemonDetailsVM.fetchPokemonDetails()
        waitForExpectations(timeout: 100)
    }
    
    func pokemonFetchFailed() {
        XCTAssert(true, "pokemon fetch failed")
        expectation.fulfill()
    }

    func pokemonFetchSucceeded(details: RemotePokemonDetails) {
        XCTAssert(details.name != "")
        XCTAssert(details.weight != 0)
        XCTAssert(details.height != 0)
        
        XCTAssert(details.types.count != 0)
        for type in details.types {
            XCTAssert(type.slot != 0)
            XCTAssert(type.type.name != "")
        }
        
        XCTAssert(details.sprites.frontDefault != URL(string: "") ?? nil)
        expectation.fulfill()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
