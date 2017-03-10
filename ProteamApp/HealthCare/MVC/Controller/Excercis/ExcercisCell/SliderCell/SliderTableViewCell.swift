//
//  SliderTableViewCell.swift
//  Ladacu
//
//  Created by IchIT on 10/17/16.
//  Copyright © 2016 TouchSpace. All rights reserved.
//

import UIKit
@objc protocol SliderCellDelegate {
    func sliderCellDidSelectRowAt()
}
class SliderTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSlider: UIImageView!
    weak var delegate:SliderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.delegate?.sliderCellDidSelectRowAt()
        
        // Configure the view for the selected state
    }
    
}
