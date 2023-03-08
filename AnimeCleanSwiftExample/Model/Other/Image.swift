//
//  Image.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Image: Codable {
    let imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}
