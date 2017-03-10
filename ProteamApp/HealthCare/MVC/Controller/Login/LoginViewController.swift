//
//  LoginViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Google
import GoogleSignIn

class LoginViewController: BasedViewController, GIDSignInUIDelegate {

    @IBOutlet weak var btnGoogle: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().uiDelegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func btnGoogle(_ sender: Any) {
        let vc: UIViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReminderViewController")
        self.navigationController?.pushViewController(vc, animated: true)
//        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func btnFacebook(_ sender: Any) {
        
//        if AccessToken.current != nil {
//            // User is logged in, use 'accessToken' here.
//            let vc: UIViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReminderViewController")
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        } else {
//            let loginManager = LoginManager()
//            loginManager.logIn([ .email ], viewController: self) { (LoginResult) in
//                switch LoginResult {
//                case .failed(let error):
//                    print(error)
//                case .cancelled:
//                    print("User cancelled login.")
//                case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
//                    print("Logged in!")
//                    let vc: UIViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReminderViewController")
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//        }
        let vc: UIViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReminderViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    private func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    private func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        //self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    private func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true) {
        
        }
    }
}
