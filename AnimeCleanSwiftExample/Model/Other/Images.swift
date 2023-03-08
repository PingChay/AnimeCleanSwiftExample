//
//  Images.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Images: Codable {
    let imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    let maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}
