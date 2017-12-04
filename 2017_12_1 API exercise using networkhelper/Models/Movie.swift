//
//  Movie.swift
//  2017_12_1 API exercise using networkhelper
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct Movie: Codable {
    let title: String
    let episodeId: Int?
    let episodeOpening: String?
    let director: String
    enum CodingKey: String, Codable{
        case title
        case episode_id = "episodeId"
        case opening_crawl = "episodeOpening"
        case director
    }
}
