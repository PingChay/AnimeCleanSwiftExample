//
//  Pagination.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool?
    let currentPage: Int?
    let items: Items?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}
