//
//  RemotePokemonProtocol.swift
//  Pokemon
//
//  Created by Elijah Chan on 3/10/23.
//

import Foundation

protocol RemotePokemonProtocol {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<RemotePokemonList, Swift.Error>) -> Void)
    func getPokemonDetails(id: String, completion: @escaping (Result<RemotePokemonDetails, Swift.Error>) -> Void)
}
