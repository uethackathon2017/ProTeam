//
//  File.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
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
    
    struct URLs {
        static let login = "http://techkids.vn:8886/api/auth/facebook"
        static let excerciseCategory = "http://techkids.vn:8886/api/exercise/category/all"
        static let eeatCategory = "http://techkids.vn:8886/api/eat/category/all"
        static let allItemExcerCate = "http://techkids.vn:8886/api/exercise/exercise"
        static let eatCategory = "http://techkids.vn:8886/api/exercise/category/all"
        static let setting = "http://techkids.vn:8886/api/user/setting"
    }
}
