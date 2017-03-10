//
//  BasedViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/2/17.
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
        if self.btnBack != nil {
            self.btnBack.addTarget(self, action: #selector(btnBackClicked(_:)), for: .touchUpInside)
        }
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
