//
//  BasedViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class BasedViewController: UIViewController {

    @IBOutlet weak var viewCustomNav: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var strTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if self.btnBack != nil {
//            leftBarButton(imageName: "ic-btn-back")
//        }
        if self.navigationController != nil {
            Utilities.configNavigationController(navi: self.navigationController!)
            leftBarButton(imageName: "ic-btn-back")
        }
        
    }
    
    func leftBarButton(imageName: String){
        if imageName != "" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:imageName), style: .plain, target: self, action: #selector(self.btnBackClicked(_:)))
        }else{
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:""), style: .plain, target: self, action:nil)
        }
        
    }
    
    func btnBackTouchUp(_ sender: AnyObject){
        _ = self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnBackClicked(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }

}
