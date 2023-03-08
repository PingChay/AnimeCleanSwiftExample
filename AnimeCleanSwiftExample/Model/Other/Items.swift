//
//  Items.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Items: Codable {
    let count, total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}
