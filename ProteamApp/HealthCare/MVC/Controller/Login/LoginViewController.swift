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
import EAIntroView
class LoginViewController: BasedViewController, GIDSignInUIDelegate,EAIntroDelegate {

    @IBOutlet weak var btnLoginFace: UIButton!
    @IBOutlet weak var btnGoogle: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().uiDelegate = self
        btnLoginFace.isSelected = false
        showIntro()
    }
    
    func showIntro(){
        let page = EAIntroPage()
        page.bgImage = UIImage(named:"intro1")
        
        let page1 = EAIntroPage()
        page1.bgImage = UIImage(named:"intro1")
        
        let page2 = EAIntroPage()
        page2.bgImage = UIImage(named:"intro1")
        
        
        let intro = EAIntroView(frame: self.view.bounds, andPages: [page,page1,page2])
        intro?.delegate = self
        intro?.skipButton.setTitle("Skip >>", for: .normal)
        intro?.show(in: self.view, animateDuration: 0.3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func btnGoogle(_ sender: Any) {
        let vc: SlideMenuController! = createMenuView()
        
        self.navigationController?.pushViewController(vc, animated: true)
//        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func btnFacebook(_ sender: Any) {
        
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            let vc: SlideMenuController! = self.createMenuView()
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let loginManager = LoginManager()
            loginManager.logIn([ .email ], viewController: self) { (LoginResult) in
                switch LoginResult {
                    
                case .failed(let error):
                    print(error)
                    
                case .cancelled:
                    print("User cancelled login.")
                    
                case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
                    
                    self.showProgress()
                    self.view.isUserInteractionEnabled = false
                    if self.btnLoginFace.isSelected == false {
                        
                        APIModel.loginFace(accessToken.authenticationToken, completion: { (token) in
                            print("Logged in!")
                            
                            self.dismissProgress()
                            let vc: SlideMenuController! = self.createMenuView()
                            self.navigationController?.pushViewController(vc, animated: true)
                            self.btnLoginFace.isSelected = true
                            self.view.isUserInteractionEnabled = true
                        }, failure: { (error) in
                            self.btnLoginFace.isSelected = true
                            self.view.isUserInteractionEnabled = true
                            self.dismissProgress()
                        })
                    } else {
                        self.btnLoginFace.isSelected = false
                        self.view.isUserInteractionEnabled = true
                    }
                    
                }
            }
        }
        
    }
    
    // MARK: - SlideMenu
    
    fileprivate func createMenuView() -> SlideMenuController {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = MainViewController()//storyboard.instantiateViewController(withIdentifier: "EatViewController") as! EatViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        Utilities.configNavigationController(navi: nvc)
        
        //UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        var slideMenuController: SlideMenuController!
        slideMenuController = SlideMenuController.init(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //        slideMenuController.delegate = mainViewController
        
        return slideMenuController
    }
    
    // MARK: - Google
    
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
