//
//  Title.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct Title: Codable {
    let type: TitleType?
    let title: String?
}

enum TitleType: String, Codable {
    case english = "English"
    case french = "French"
    case german = "German"
    case japanese = "Japanese"
    case spanish = "Spanish"
    case synonym = "Synonym"
    case typeDefault = "Default"
}
