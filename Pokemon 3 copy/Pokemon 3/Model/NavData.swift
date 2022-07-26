//
//  NavData.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import Foundation


func getAditionalData(urlPokemonSend: String) -> PokemonType?{
    let urlToSend = URL(string: "\(urlPokemonSend)")!
    do {
        let data = try Data(contentsOf: urlToSend)
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        guard let baseDict = jsonObj as? [String: Any] else { return nil }
        return parsePokemonManually(baseDict: baseDict)
    } catch {
        print(error)
    }
    return nil
}
func parsePokemonManually(baseDict: [String: Any]) -> PokemonType? {
    guard let spritesDict = baseDict["sprites"] as? [String: Any] else { return nil }
    let backDefault = spritesDict["back_default"] as? String
    let backFemale = spritesDict["back_female"] as? String
    let backShiny = spritesDict["back_shiny"] as? String
    let backShinyFemale = spritesDict["back_shiny_female"] as? String
    let frontDefault = spritesDict["front_default"] as? String
    let frontFemale = spritesDict["front_female"] as? String
    let frontShiny = spritesDict["front_shiny"] as? String
    let frontShinyFemale = spritesDict["front_shiny_female"] as? String
    let sprites = Sprites(back_default: backDefault, back_female: backFemale, back_shiny: backShiny, back_shiny_female: backShinyFemale, front_default: frontDefault, front_female: frontFemale, front_shiny: frontShiny, front_shiny_female: frontShinyFemale)
    
    
    var pokeAbilities = ""
    var baseExp = 0
    var basicForms: [BasicData] = []
    var gameIndeces: [GameIndex] = []
    var ability: [Ability] = []
    //var Types: [BasicData] = []
    var types: [Types] = []
    var height = 0
    var id = 0
    var isDefault = true
    var locations = ""
    var name = ""
    var order = 0
    guard let weight = baseDict["weight"] as? Int else { return nil }
    var poke_move: [Move] = []
    
    
    return PokemonType(abilities: ability, base_experience: baseExp, forms: basicForms, game_indices: gameIndeces, height: height, id: id, is_default: isDefault, location_area_encounters: locations, moves: poke_move, name: name, order: order, sprites: sprites, types: types, weight: weight)
}
func createBasicData(dict: [String: Any]) -> BasicData? {
    guard let name = dict["name"] as? String else { return nil }
    guard let url = dict["url"] as? String else { return nil }
    return BasicData(name: name, url: url)
}
