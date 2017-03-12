//
//  DetailFood.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/12/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import Foundation

struct DetailFood {
    
    var _id: String! = ""
    var name: String?
    var img: String?
    var guide: String?
    
    
    init?(jsonData:[String:Any]) {
        self._id = jsonData["_id"] as? String
        self.name = jsonData["name"] as? String
        
        if let img = jsonData["img"] as? String {
            self.img = img
        }
        if let guide = jsonData["guide"] as? String {
            self.guide = guide
        }
    }
    
    init(){
    }
}
