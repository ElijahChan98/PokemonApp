//
//  MockRemotePokemonDataSource.swift
//  PokemonTests
//
//  Created by Elijah Chan on 3/10/23.
//

import Foundation

class MockRemotePokemonDataSource: RemotePokemonProtocol {
    static let shared = MockRemotePokemonDataSource()
    
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<RemotePokemonList, Swift.Error>) -> Void) {
        var pokemonListItems: [RemotePokemonListItem] = []
        for i in 1...limit {
            let pokemon = RemotePokemonListItem(name: "Pokemon\(i)", url: URL(string: "URL\(i)")!)
            pokemonListItems.append(pokemon)
        }
        
        completion(.success(RemotePokemonList(results: pokemonListItems, count: limit)))
    }
    
    func getPokemonDetails(id: String, completion: (Result<RemotePokemonDetails, Swift.Error>) -> Void) {
        let randomWeight = Int.random(in: 20...100)
        let randomHeight = Int.random(in: 2...150)
        let randomType = MockPokemonTypes.types.randomElement()
        var remotePokemonType: RemotePokemonType!
        
        for (key, value) in randomType! {
            remotePokemonType = RemotePokemonType(slot: key, type: RemotePokemonTypeResource(name: value))
        }
        
        var randomURL = URL(string: "URL\(id)")
        
        completion(.success(RemotePokemonDetails(name: "Pokemon\(id)", weight: randomWeight, height: randomHeight, types: [remotePokemonType], sprites: RemotePokemonSprites(frontDefault: randomURL!))))
    }
}
