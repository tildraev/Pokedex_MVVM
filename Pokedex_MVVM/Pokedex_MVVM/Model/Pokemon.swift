//
//  Pokemon.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import Foundation

struct Pokemon: Decodable {
    let abilities: [AbilityDict]
    let moves: [MovesDict]
    let sprites: Sprites
    let name: String
    let id: Int
    let weight: Int
}

struct AbilityDict: Decodable {
    let ability: Ability
}
struct Ability: Decodable {
    let name: String
}

struct MovesDict: Decodable {
    let move: Move
}

struct Move: Decodable {
    let name: String
}

struct Sprites: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?
}
