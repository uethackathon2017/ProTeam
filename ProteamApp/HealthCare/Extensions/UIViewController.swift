
//
//  UIViewControllerExtensions.swift
//  azasu
//
//  Created by IchIT on 11/16/16.
//  Copyright © 2016 Ich Van Ninh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    public func dismissKeyboard() {
        view.endEditing(true)
    }
}
