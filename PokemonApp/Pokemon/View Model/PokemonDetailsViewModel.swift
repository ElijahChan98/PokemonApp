//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Elijah Chan on 3/10/23.
//

import Foundation

class PokemonDetailsViewModel {
    var id: String!
    var delegate: PokemonDetailsDelegate?
    private(set) var dataSource: RemotePokemonProtocol = RemotePokemonDataSource.shared
    
    init(id: String, dataSource: RemotePokemonProtocol = RemotePokemonDataSource.shared) {
        self.id = id
        self.dataSource = dataSource
    }
    
    func fetchPokemonDetails() {
        dataSource.getPokemonDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self?.delegate?.pokemonFetchSucceeded(details: details)
                case .failure(_):
                    self?.delegate?.pokemonFetchFailed()
                }
            }
        }
    }
}

protocol PokemonDetailsDelegate {
    func pokemonFetchSucceeded(details: RemotePokemonDetails)
    func pokemonFetchFailed()
}
