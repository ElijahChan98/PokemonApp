//
//  RemotePokemonList.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation

struct RemotePokemonList: Decodable {
    let results: [RemotePokemonListItem]
    let count: Int
    
    // create an init statement for non decoded declarations for testing
    init(results: [RemotePokemonListItem], count: Int) {
        self.results = results
        self.count = count
    }
}
