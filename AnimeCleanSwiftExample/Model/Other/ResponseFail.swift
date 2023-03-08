//
//  ResponseFail.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

struct ResponseFail: Codable {
    let status: Int?
    let type, message, error: String?
}
