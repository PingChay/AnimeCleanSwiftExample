//
//  Anime.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Anime: Codable {
    let malID: Int?
    let url: String?
    let images: [String: Image]?
    let trailer: Trailer?
    let approved: Bool?
    let titles: [Title]?
    let title: String?
    let titleEnglish: String?
    let titleJapanese: String?
    let titleSynonyms: [String]?
    let type: String?
    let source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let aired: Aired?
    let duration: String?
    let rating: String?
    let score: Double?
    let scoredBy, rank, popularity, members: Int?
    let favorites: Int?
    let synopsis: String?
    let background: String?
    let season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers, licensors, studios, genres: [Demographic]?
    let themes, demographics: [Demographic]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case themes, demographics
    }
}
