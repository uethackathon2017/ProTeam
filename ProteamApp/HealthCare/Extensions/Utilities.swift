//
//  Utilities.swift
//  azasu
//
//  Created by Ich Van Ninh on 9/9/16.
//  Copyright © 2016 Ichnv. All rights reserved.
//

import UIKit
import SAMKeychain

class Utilities{
    
    class func formatDoubleNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        return numberFormatter.string(from: NSNumber(value:number))!
    }
    
    class func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}
