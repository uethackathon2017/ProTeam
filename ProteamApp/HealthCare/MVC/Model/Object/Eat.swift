//
//  Eat.swift
//  HealthCare
//
//  Created by IchIT on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import Foundation
struct Eat{
    var _id:String! = ""
    var name:String?
    var img:String?
    
    init?(jsonData:[String:Any]) {
        self._id = jsonData["_id"] as? String
        self.name = jsonData["name"] as? String
        
        if let img = jsonData["img"] as? String {
            self.img = img
        }
        
    }
    
    init(){
    }
}
