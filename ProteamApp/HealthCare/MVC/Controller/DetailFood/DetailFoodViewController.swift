//
//  DetailFoodViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class DetailFoodViewController: BasedViewController {
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var imvCake: UIImageView!
    @IBOutlet weak var viewCake: UIView!
    @IBOutlet weak var imvOfFood: UIImageView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewTail: UIView!
    @IBOutlet weak var txtViewContentFood: UITextView!
    @IBOutlet weak var btnLove: UIButton!
    var isFavourite: Bool! = false
    var _id: String!
    var detailFood: DetailFood!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.firstInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    
    func firstInit() {
        self.viewCake.layer.cornerRadius = self.viewCake.bounds.size.width/2
        self.imvCake.layer.cornerRadius = self.imvCake.bounds.size.width/2
        self.viewHeader.layer.cornerRadius = 5
        self.viewTail.layer.cornerRadius = 5
        self.txtViewContentFood.layer.cornerRadius = 5
        
        self.txtViewContentFood.isEditable = false
        
        updateButtonLove()
        loadData()
    }
    
    func loadData() {
        self.showProgress()
        APIModel.getDetailFood(self._id, completion: { (result) in
            self.detailFood = result as! DetailFood
            let content: NSAttributedString = (self.detailFood.guide)!.html2AttributedString!
            self.lblFood.text = self.detailFood.name
            self.imvOfFood.sd_setImage(with: URL.init(string: self.detailFood.img!), placeholderImage: UIImage.init(named: "no_image"))
            self.imvOfFood.contentMode = .scaleAspectFill
            self.imvOfFood.clipsToBounds = true
            self.txtViewContentFood.attributedText = content
            self.dismissProgress()
        }) { (fail) in
            print("ERROR: " + "\(fail)")
            self.dismissProgress()
        }
    }
    
    // MARK: - Action
    
    func updateButtonLove() {
        if isFavourite == false {
            self.btnLove.setBackgroundImage(UIImage.init(named: "icon_love"), for: .normal)
        } else {
            self.btnLove.setBackgroundImage(UIImage.init(named: "icon_loved"), for: .normal)
        }
    }
    
    @IBAction func btnLoveClicked(_ sender: Any) {
        if btnLove.isSelected == false {
            
            btnLove.isUserInteractionEnabled = false
            
            APIModel.likeFood(self.detailFood._id, completion: { (mes) in
                self.btnLove.setImage(UIImage(named: "icon_loved"), for: .normal)
                self.btnLove.isUserInteractionEnabled = true
            }, failure: { (fail) in
                self.btnLove.isUserInteractionEnabled = true

            })
            
        } else {
            
            btnLove.isUserInteractionEnabled = false
            
            APIModel.unlikeFood(self.detailFood._id, completion: { (mes) in
                self.btnLove.setImage(UIImage(named: "icon_love"), for: .normal)
                self.btnLove.isUserInteractionEnabled = true
            }, failure: { (fail) in
                self.btnLove.isUserInteractionEnabled = true
            })
            
        }
        btnLove.isSelected = !btnLove.isSelected
    }
}
