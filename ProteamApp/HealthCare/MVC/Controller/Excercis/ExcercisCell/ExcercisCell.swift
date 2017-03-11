//
//  ExcercisCell.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import SDWebImage
protocol ExcercisCellDelegate {
    func btnSeeAllTouchup(_ index: Int)
    func didSelectRowAtSliderCell(exercise:Exercise,title:String)
}
class ExcercisCell: UITableViewCell {
    
    let cellIdentifier = "SliderTableViewCell"
    @IBOutlet weak var tbvTopicExcercis: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var excercises = [Exercise]()
    var index:Int?
    
    var delegate:ExcercisCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tbvTopicExcercis.translatesAutoresizingMaskIntoConstraints = false
        self.tbvTopicExcercis.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        
        self.tbvTopicExcercis.showsVerticalScrollIndicator = false
        self.tbvTopicExcercis.showsHorizontalScrollIndicator = false
        self.tbvTopicExcercis.separatorStyle = .none
        self.tbvTopicExcercis.backgroundColor = UIColor(hex: "#ffffff")
        self.tbvTopicExcercis.frame = CGRect(x: 0,y: 40,width: Constants.Systems.screen_size.width - 14,height: 95)
        tbvTopicExcercis.contentInset = UIEdgeInsets(top: 14,left: 0,bottom:0,right: 0)
        tbvTopicExcercis.delegate = self
        tbvTopicExcercis.dataSource = self
        self.tbvTopicExcercis.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func btnSeeAllTouchup(_ sender: Any) {
        self.delegate?.btnSeeAllTouchup(self.index ?? 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension ExcercisCell:UITableViewDelegate,UITableViewDataSource{
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excercises.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SliderTableViewCell
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        cell.selectionStyle = .none
        
        if let thumnail = excercises[indexPath.row].thumnail {
            cell.imgSlider.sd_setImage(with: URL.init(string: thumnail))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let title = excercises[indexPath.row].name {
            self.delegate?.didSelectRowAtSliderCell(exercise: excercises[indexPath.row],title: title)
        }
        
    }
}
