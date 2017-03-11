//
//  FavoriteExTableViewCell.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class FavoriteExTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imvContent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
