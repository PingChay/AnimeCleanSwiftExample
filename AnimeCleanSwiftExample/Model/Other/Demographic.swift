//
//  Demographic.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Demographic: Codable {
    let malID: Int?
    let type: String?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}
