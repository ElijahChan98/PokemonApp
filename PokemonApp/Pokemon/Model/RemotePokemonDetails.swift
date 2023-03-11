//
//  RemotePokemonDetails.swift
//  Pokemon
//
//  Created by Ben Rosen on 11/10/2022.
//
import Foundation

struct RemotePokemonDetails: Decodable {
    let name: String
    let weight: Int
    let height: Int
    let types: [RemotePokemonType]
    let sprites: RemotePokemonSprites
    
    init(name: String, weight: Int, height: Int, types: [RemotePokemonType], sprites: RemotePokemonSprites) {
        self.name = name
        self.weight = weight
        self.height = height
        self.types = types
        self.sprites = sprites
    }
}

struct RemotePokemonType: Decodable {
    let slot: Int
    let type: RemotePokemonTypeResource
    
    init(slot: Int, type: RemotePokemonTypeResource) {
        self.slot = slot
        self.type = type
    }
}

struct RemotePokemonTypeResource: Decodable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct RemotePokemonSprites: Decodable {
    let frontDefault: URL
    
    init(frontDefault: URL) {
        self.frontDefault = frontDefault
    }
}
