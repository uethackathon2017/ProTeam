
//
//  UIViewControllerExtensions.swift
//  azasu
//
//  Created by IchIT on 11/16/16.
//  Copyright © 2016 Ich Van Ninh. All rights reserved.
//

import UIKit
import SVProgressHUD
extension UIViewController {
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    final func showProgress(_ title: String? = "") {
        SVProgressHUD.show()
    }
    
    final func dismissProgress() {
        // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // MRProgressOverlayView.dismissAllOverlaysForView(appDelegate.window, animated: true)
        SVProgressHUD.dismiss()
        
    }
}
