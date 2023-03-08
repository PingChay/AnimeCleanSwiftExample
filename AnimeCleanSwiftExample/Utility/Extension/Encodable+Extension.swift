//
//  Encodable+Extension.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import UIKit

extension [String: Any] {
    func toJSONData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func toJSONString() -> String? {
        guard let jsonData = toJSONData() else {
            return nil
        }

        return String(data: jsonData, encoding: .utf8)
    }

    func map<D: Decodable>(_ type: D.Type, decoder: JSONDecoder = JSONDecoder()) -> D? {
        guard let data = toJSONData() else {
            return nil
        }

        return try? decoder.decode(D.self, from: data)
    }
}

extension Encodable {
    func toJSONString(using encoder: JSONEncoder = JSONEncoder()) -> String? {
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }

    func toDictionary() -> [String: Any]? {
        if let data = toJSONString()?.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                return json
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
