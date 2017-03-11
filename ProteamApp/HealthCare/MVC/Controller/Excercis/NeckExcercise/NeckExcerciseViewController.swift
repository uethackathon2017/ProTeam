//
//  NeckExcerciseViewController.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import SnapKit
class NeckExcerciseViewController: BasedViewController {
    
    @IBOutlet weak var lblDes: UILabel!
    var viewPlayer = PlayingView()
    let lblDescribe = "Describe"
    var youtube_id:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         viewPlayer = UIView.loadFromNibNamed("PlayingView") as! PlayingView
        if youtube_id != nil {
            viewPlayer.initPlayerView(videoID: "dyfMD94d2Yc")
        }
        
        self.view.addSubview(viewPlayer)
        viewPlayer.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(118)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(210)
        }

        self.title = "Neck excercise"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
