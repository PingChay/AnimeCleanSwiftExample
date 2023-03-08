//
//  AnimeProvider.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 2/3/2566 BE.
//

import Foundation
import Moya

enum AnimeProvider {
    case getAnime(request: GetAnimeRequest)
}

extension AnimeProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.jikan.moe/v4")!
    }

    var path: String {
        switch self {
            case .getAnime:
                return "/anime"
        }
    }

    var method: Moya.Method {
        switch self {
            case .getAnime:
                return .get
        }
    }

    var task: Moya.Task {
        switch self {
            case let .getAnime(request: request):
                return .requestParameters(parameters: request.toDictionary() ?? [:],
                                          encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=utf-8"]
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
