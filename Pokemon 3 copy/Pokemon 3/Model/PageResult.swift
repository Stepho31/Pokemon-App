//
//  PageResult.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import Foundation

struct PokemonType: Decodable{
    let abilities: [Ability]
    let base_experience: Int
    let forms: [BasicData]
    let game_indices: [GameIndex]
    let height: Int
    //let held_items: [HeldItem]
    let id: Int
    let is_default: Bool
    let location_area_encounters: String
    let moves: [Move]
    let name: String
    let order: Int
    //let past_types: [BasicData]
    //let species: BasicData
    let sprites: Sprites
    //let stats: [Stat]
    let types: [Types]
    let weight: Int
}
struct Stat: Decodable {
    let base_stat: Int
    let effort: Int
    let stat: BasicData
    
}

struct Types: Decodable{
    let slot: Int
    let type: BasicData
}

struct Ability: Decodable {
    let ability: BasicData
    let is_hidden: Bool
    let slot: Int
}

struct GameIndex: Decodable {
    let game_index: Int
    let version: BasicData
}

struct HeldItem: Decodable {
    let item: BasicData
    let version_details: [VersionDetails]
}

struct VersionDetails: Decodable {
    let rarity: Int
    let version: BasicData
}

struct Move: Decodable {
    let move: BasicData
}

struct VersionGroupDetails: Decodable {
    let level_learned_at: Int
    let move_learn_method: BasicData
    let version_group: BasicData
}

struct Sprites: Decodable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct OtherData: Decodable {
    let dream_world: DreamWorld
    let home: Home
}

struct DreamWorld: Decodable {
    let front_default: String?
    let front_female: String?
}

struct Home: Decodable {
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct BasicData: Decodable {
    let name: String
    let url: String
}
