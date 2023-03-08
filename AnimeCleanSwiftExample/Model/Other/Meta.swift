//
//  Meta.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Meta: Codable {
    let currentPage, from, lastPage: Int?
    let links: [Link]?
    let path: String?
    let perPage, to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case links, path
        case perPage = "per_page"
        case to, total
    }
}
