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
    var exercise = Exercise()
    var btnLike = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         viewPlayer = UIView.loadFromNibNamed("PlayingView") as! PlayingView
        if let youtube_id = exercise.youtube_id {
            viewPlayer.initPlayerView(videoID: youtube_id)
        }
        
        self.view.addSubview(viewPlayer)
        viewPlayer.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(118)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(210)
        }
        viewPlayer.setCornerRadius(radius: 5)
        self.navigationController?.navigationBar.isHidden = false
        createRightBar()
    }

    func createRightBar(){
        
        btnLike.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        btnLike.setImage(UIImage(named: "icon_love"), for: .normal)
        
        btnLike.addTarget(self, action: #selector(btnRightNaviPressed), for: .touchUpInside)
        btnLike.isSelected = false
        let btnLikeItem = UIBarButtonItem(customView: btnLike)
        
        self.navigationItem.setRightBarButtonItems([btnLikeItem], animated: true)
    }
    
    func btnRightNaviPressed(){
        if btnLike.isSelected == false{
            
            btnLike.isUserInteractionEnabled = false
            APIModel.likeExercise(exercise._id, completion: { (mes) in
                self.btnLike.setImage(UIImage(named: "ic-excercise"), for: .normal)
                self.btnLike.isUserInteractionEnabled = true
            }, failure: { (error) in
               self.btnLike.isUserInteractionEnabled = true
            })
        }else{
            btnLike.isUserInteractionEnabled = false
            APIModel.unlikeExercise(exercise._id, completion: { (mes) in
                self.btnLike.setImage(UIImage(named: "icon_love"), for: .normal)
                self.btnLike.isUserInteractionEnabled = true
            }, failure: { (error) in
                self.btnLike.isUserInteractionEnabled = true
            })
            
        }
        btnLike.isSelected = !btnLike.isSelected
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
