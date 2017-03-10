//
//  ExcercisCell.swift
//  HealthCare
//
//  Created by IchIT on 3/5/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class ExcercisCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {

   let cellIdentifier = "SliderTableViewCell"
    @IBOutlet weak var tbvTopicExcercis: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tbvTopicExcercis.translatesAutoresizingMaskIntoConstraints = false
        self.tbvTopicExcercis.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        
        self.tbvTopicExcercis.showsVerticalScrollIndicator = false
        self.tbvTopicExcercis.showsHorizontalScrollIndicator = false
        self.tbvTopicExcercis.separatorStyle = .none
        self.tbvTopicExcercis.backgroundColor = UIColor(hexString: "#ffffff")
        self.tbvTopicExcercis.frame = CGRect(x: 0,y: 40,width: Constants.Systems.screen_size.width - 14,height: 95)
        tbvTopicExcercis.contentInset = UIEdgeInsets(top: 14,left: 0,bottom:0,right: 0)
        tbvTopicExcercis.delegate = self
        tbvTopicExcercis.dataSource = self
        self.tbvTopicExcercis.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SliderTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        cell.selectionStyle = .none
        cell.imgSlider.image = UIImage.init(named: "img-demo")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let preview = PreviewViewController()
       // self.delegate?.didTopicCardSliderCell(sender: listCard[indexPath.row])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
