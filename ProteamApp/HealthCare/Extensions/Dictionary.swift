//
//  Dictionary.swift
//  azasu
//
//  Created by IchIT on 11/20/16.
//  Copyright © 2016 Ich Van Ninh. All rights reserved.
//

import UIKit

extension Dictionary where Value: Comparable {
    
    var valueKeySorted: [(Key, Value)] {
        return sorted{ if $0.value != $1.value { return $0.value > $1.value } else { return String(describing: $0.key) < String(describing: $1.key) } }
    }
}
