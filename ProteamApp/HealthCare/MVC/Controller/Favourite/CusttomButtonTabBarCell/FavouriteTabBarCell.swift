//
//  FavouriteTabBarCell.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavouriteTabBarCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    var indicatorInfo: IndicatorInfo!
    
    @IBOutlet weak var viewContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
