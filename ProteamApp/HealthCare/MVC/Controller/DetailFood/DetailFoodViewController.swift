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
        //self.txtViewContentFood.attributedText =
        updateButtonLove()
        loadData()
    }
    
    func loadData() {
        self.showProgress()
        APIModel.getDetailFood(self._id, completion: { (result) in
            let detailFood:DetailFood! = result as! DetailFood
            let content: NSAttributedString = (detailFood.guide)!.html2AttributedString!
            self.lblFood.text = detailFood.name
            self.imvOfFood.sd_setImage(with: URL.init(string: detailFood.img!), placeholderImage: UIImage.init(named: ""))
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
        self.isFavourite = !self.isFavourite
        updateButtonLove()
    }
}
