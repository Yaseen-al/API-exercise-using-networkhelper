//
//  Characters.swift
//  2017_12_1 API exercise using networkhelper
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct Results: Codable {
    let results: [Character]
}
struct Character: Codable {
    let name: String
    let weight: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let gender: String
    let films: [String]
    let starships: [String]
    var movies: [Movie]?
    
    // this is the way that you can change the keyNamse for your specific purpose
    enum CodingKeys: String, CodingKey{
        case name
        case weight = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case gender
        case films
        case starships
        case movies
    }
}

