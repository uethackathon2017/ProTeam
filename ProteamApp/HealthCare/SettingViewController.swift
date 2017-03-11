//
//  SettingViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class SettingViewController: BasedTableViewController {

    var arrTitleCell = ["Remind to drink", "Remind to eat", "Remind to exercise", "Notification"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    func btnSwitchRepeatRingtonClicked(_ sender: UISwitch) {


    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitleCell.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "UITableViewCell")
        }
        
        cell.textLabel?.textColor = UIColor.init(hex: "#471601")
        cell.detailTextLabel?.textColor = UIColor.init(hex: "#e7beac")
        
        let bgView: UIView = UIView.init()
        bgView.backgroundColor = UIColor.init(hex: "#FFA613")
        cell.selectedBackgroundView = bgView
        
        cell.textLabel?.text = arrTitleCell[indexPath.row]
        
        if indexPath.row != arrTitleCell.count - 1 {
            
            let imvAccessory: UIImageView! = UIImageView.init(image: UIImage.init(named: "next"))
            imvAccessory.contentMode = .scaleAspectFit
            cell.accessoryView = imvAccessory
            
        } else {
            
            let btnSwitchRepeatRington:UISwitch = UISwitch()
            btnSwitchRepeatRington.addTarget(self, action: #selector(SettingViewController.btnSwitchRepeatRingtonClicked(_:)), for: .valueChanged)
            btnSwitchRepeatRington.onTintColor = UIColor.init(hex: "#ffd900")
            cell.accessoryView = btnSwitchRepeatRington
            cell.detailTextLabel?.text = ""
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        if ( indexPath.row != arrTitleCell.count - 1 ) {
            
            let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            
            let vc: MainAlarmViewController! = mainStoryboard.instantiateViewController(withIdentifier: "MainAlarmViewController") as! MainAlarmViewController
            vc.typeView = indexPath.row
            
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            
            
            
        }
        
    }

}
