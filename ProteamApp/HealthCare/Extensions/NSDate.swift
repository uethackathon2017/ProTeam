//
//  NSDate.swift
//  azasu
//
//  Created by Ichnv on 8/23/16.
//  Copyright © 2016 Ichnv. All rights reserved.
//

import UIKit

extension Date {
    
    func stringDateWithFormat(_ dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let vnLocale : Locale = Locale.init(identifier :  "vi")
        dateFormatter.locale = vnLocale
        let day = dateFormatter.string(from: self)
        return day
    }
    
    func toDay(_ stringDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let strDate = dateFormatter.string(from: Date())
        let minute = DateFormatter()
        minute.dateFormat = "hh:mm"
        let strMinute = minute.string(from: Date())
        if strDate == stringDate{
            return String(format: "%@ Hôm nay", strMinute)
        } else {
            return stringDate
        }
    }
    
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
            formatter.locale = Locale(identifier: "vi_VN")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter
        }()
    }
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}
