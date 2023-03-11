//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Elijah Chan on 3/10/23.
//

import Foundation

class PokemonListViewModel {
    var morePokemonToLoad = true
    var pokemon = [RemotePokemonListItem]()
    var delegate: PokemonListDelegate?
    var limit: Int = 20
    private(set) var dataSource: RemotePokemonProtocol = RemotePokemonDataSource.shared
    
    init(dataSource: RemotePokemonProtocol = RemotePokemonDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func fetchMorePokemon() {
        dataSource.getPokemonList(offset: pokemon.count, limit: limit) { [weak self] result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self?.pokemonFetchSucceeded(pokemonList: pokemonList)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.pokemonFetchFailed()
                }
            }
        }
    }
    
    private func pokemonFetchSucceeded(pokemonList: RemotePokemonList) {
        pokemon.append(contentsOf: pokemonList.results)

        if pokemon.count == pokemonList.count {
            morePokemonToLoad = false
        }

        self.delegate?.reloadTable()
    }
    
    private func pokemonFetchFailed() {
        self.delegate?.showErrorMessage?(title: nil, message: "We could not fetch some Pokemon, please try again later.")
    }
}

@objc protocol PokemonListDelegate {
    func reloadTable()
    @objc optional func showErrorMessage(title: String?, message: String)
}
