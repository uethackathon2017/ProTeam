//
//  Exercise.swift
//  HealthCare
//
//  Created by IchIT on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import Foundation
struct Exercise{
    var _id:String! = ""
    var name:String?
    var youtube_id:String?
    var thumnail:String?
    
    init?(jsonData:[String:Any]) {
        self._id = jsonData["_id"] as? String
        self.name = jsonData["name"] as? String
        
        if let thumnail = jsonData["thumnail"] as? String {
            self.thumnail = thumnail
        }
        
        if let youtube_id = jsonData["youtube_id"] as? String {
            self.youtube_id = youtube_id
        }
    }
    
    init(){
    }
}
