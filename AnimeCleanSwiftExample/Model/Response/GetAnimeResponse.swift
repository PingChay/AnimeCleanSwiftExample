//
//  GetAnimeResponse.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct GetAnimeResponse: Codable {
    let pagination: Pagination?
    let data: [Anime]?
    let links: Links?
    let meta: Meta?
}
