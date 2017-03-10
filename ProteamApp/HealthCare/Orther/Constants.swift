//
//  File.swift
//  HealthCare
//
//  Created by IchIT on 3/5/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
struct Constants {
    
    struct Systems {
        static let scale : CGFloat                          = UIScreen.main.bounds.size.width/375.0
        static let screen_size : CGSize                     = UIScreen.main.bounds.size
        static let delegate: AppDelegate                    = UIApplication.shared.delegate as! AppDelegate
        static let device_version                           = (UIDevice.current.systemVersion as NSString).floatValue
        
        static let device_name: String                      = UIDevice.current.name
        static let system_name: String                      = UIDevice.current.systemName
        static let system_version: String                   = UIDevice.current.systemVersion
    }
    struct DelegateObject{
        var lblChuRe: String?
        var lblCoDau: String?
        var date:NSDate?
        var adress:AnyObject?
    }
    struct URLs {
        static let BaseURL: String = "http://ladaku.touchspace.vn/api/"
        // static let ApiURL: String = "api/"
        static let BaseURLMediaUpload = "http://media.touchspace.vn/uploads"
    }
    
}
