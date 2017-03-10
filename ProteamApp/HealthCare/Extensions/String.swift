//
//  String.swift
//  azasu
//
//  Created by Ichnv on 6/2/16.
//  Copyright © 2016 Ichnv. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func dateWithStringFormat(_ string:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        let date = dateFormatter.date(from: self)
        return date!
    }
    //cover date ISO8601
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
//    subscript (r: Range<Int>) -> String {
//        let start = characters.index(startIndex, offsetBy: r.lowerBound)
//        let end = <#T##String.CharacterView corresponding to `start`##String.CharacterView#>.index(start, offsetBy: r.upperBound - r.lowerBound)
//        return self[Range(start ..< end)]
//    }
}
