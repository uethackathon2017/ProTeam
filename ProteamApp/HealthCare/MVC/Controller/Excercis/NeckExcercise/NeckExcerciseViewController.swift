//
//  NeckExcerciseViewController.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import SnapKit
class NeckExcerciseViewController: UIViewController {
    
    @IBOutlet weak var lblDes: UILabel!
    var viewPlayer = PlayingView()
    let lblDescribe = "Describe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         viewPlayer = UIView.loadFromNibNamed("PlayingView") as! PlayingView
        viewPlayer.initPlayerView(videoID: "dyfMD94d2Yc")
        self.view.addSubview(viewPlayer)
        viewPlayer.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(114)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(210)
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
