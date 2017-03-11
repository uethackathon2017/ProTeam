//
//  LeftMenuViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
}

class LeftMenuViewController: BasedTableViewController {

    var arrTitleCell = ["Home", "Setting", "Favourite","Sign out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitleCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell.textLabel?.font = UIFont.init(name: "UTM-Neo-Sans-Intel", size: 18)
        cell.textLabel?.textColor = UIColor.init(hex: "#471500")
        
        let bgView: UIView = UIView.init()
        bgView.backgroundColor = UIColor.init(hex: "#FFA613")
        cell.selectedBackgroundView = bgView
        
        cell.textLabel?.text = arrTitleCell[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader: UIView! = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.tableView.frame.size.width, height: 30))
        viewHeader.backgroundColor = UIColor.clear
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
                
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        if indexPath.row == 0 {
            // Home
            
            slideMenuController()?.closeLeft()
            
        } else if indexPath.row == 1 {
            // Setting
            
            let vc: UIViewController! = mainStoryboard.instantiateViewController(withIdentifier: "SettingViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else if indexPath.row == 2 {
            // Favourite
            
            let vc = FavouritesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 3 {
            // Sign out
            
            var checkExistLoginVc: Bool! = false
            for vc in (self.navigationController?.viewControllers)! {
                if vc.isKind(of: LoginViewController.self) {
                    checkExistLoginVc = true
                    _ = self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
            if checkExistLoginVc == false {
                _ = self.navigationController?.popToRootViewController(animated: false)
                let vc: UIViewController! = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
