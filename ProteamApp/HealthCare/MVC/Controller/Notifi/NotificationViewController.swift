//
//  NotificationViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

protocol NotificationViewControllerDelegate {
    func repeatClicked(notification: UILocalNotification, vc: NotificationViewController)
    func shutDownClicked(notification: UILocalNotification, vc: NotificationViewController)
}

class NotificationViewController: BasedViewController {

    @IBOutlet weak var btnRepeat: UIButton!
    @IBOutlet weak var btnShutdown: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSalutation: UILabel!
    var strSalutation: String!
    var delegate: NotificationViewControllerDelegate!
    var notification: UILocalNotification!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnShutdown.layer.borderWidth = 1
        btnShutdown.layer.borderColor = UIColor.init(hex: "#471500").cgColor
        btnShutdown.layer.cornerRadius = btnShutdown.bounds.size.height / 2
        
        btnRepeat.layer.borderWidth = 1
        btnRepeat.layer.borderColor = UIColor.init(hex: "#471500").cgColor
        btnRepeat.layer.cornerRadius = btnShutdown.bounds.size.height / 2
        
        lblSalutation.text = strSalutation
        
        let date = Date()
        let hour = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)

        lblTime.text = String(hour).appending(":").appending(String(minutes))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func btnShutdownClicked(_ sender: Any) {
        self.delegate.shutDownClicked(notification: self.notification, vc: self)
    }
    
    @IBAction func btnRepeatClicked(_ sender: Any) {
        self.delegate.repeatClicked(notification: self.notification, vc: self)
    }

}
