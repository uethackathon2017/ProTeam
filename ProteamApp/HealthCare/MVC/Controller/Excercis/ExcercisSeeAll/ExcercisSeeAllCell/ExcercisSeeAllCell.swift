//
//  ExcercisSeeAllCell.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class ExcercisSeeAllCell: UICollectionViewCell {

    @IBOutlet weak var imgVideo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgVideo.setCornerRadius(radius: 2)
    }

}
