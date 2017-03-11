//
//  ExerciseCategory.swift
//  HealthCare
//
//  Created by IchIT on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import Foundation

struct ExerciseCategory{
    var _id:String! = ""
    var name:String?
    var items:[Exercise]?

    
    init?(jsonData:[String:Any]) {
        self._id = jsonData["_id"] as? String
        self.name = jsonData["name"] as? String
        
        if let items = jsonData["items"] as? [[String:Any]] {
            var tempArr = [Exercise]()
            for each in items {
                if let obj = Exercise(jsonData: each) {
                    tempArr.append(obj)
                }
            }
            self.items = tempArr
        }
    }
    init(){
    }
}
