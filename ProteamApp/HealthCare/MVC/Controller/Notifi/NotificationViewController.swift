//
//  NotificationViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/6/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class NotificationViewController: BasedViewController {

    @IBOutlet weak var btnShutdown: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSalutation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnShutdown.layer.borderWidth = 1
        btnShutdown.layer.borderColor = UIColor.init(hex: "#471500").cgColor
        btnShutdown.layer.cornerRadius = btnShutdown.bounds.size.height / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShutdownClicked(_ sender: Any) {
        
    }
    

}
