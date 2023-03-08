//
//  Trailer.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Trailer: Codable {
    let youtubeID: String?
    let url, embedURL: String?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}
