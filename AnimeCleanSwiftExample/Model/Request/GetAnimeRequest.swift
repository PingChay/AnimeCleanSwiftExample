//
//  GetAnimeRequest.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct GetAnimeRequest: Codable {
    let keyword: String?
    let page: Int?

    enum CodingKeys: String, CodingKey {
        case keyword = "q"
        case page = "page"
    }
}
