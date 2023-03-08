//
//  String+Extension.swift
//  EatAndFork
//
//  Created by Saran Nonkamjan on 9/2/2566 BE.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
