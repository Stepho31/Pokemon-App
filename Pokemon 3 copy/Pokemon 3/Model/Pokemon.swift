//
//  Pokemon.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let url: String
}
struct PageResult: Decodable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

