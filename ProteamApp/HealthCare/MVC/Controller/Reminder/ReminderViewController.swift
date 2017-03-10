//
//  ReminderViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import MediaPlayer

class ReminderViewController: BasedTableViewController, UIPickerViewDelegate, UIPickerViewDataSource, MPMediaPickerControllerDelegate {

    @IBOutlet weak var pickerViewTime: UIPickerView!
    var btnSwitchRepeatRington: UISwitch!
    var currentTime: Date!
    var arrTitleCell = ["Repeat", "Rington", "Salutation", "Repeat Rington"]
    var arrDetailTitleCell = ["Monday, Friday", "Nơi này có anh", "Time to exercises, Vinh !"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.firstInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - First Init
    
    func firstInit() {
        
        pickerViewTime.tintColor = UIColor.init(hex: "#ffbe53")
        pickerViewTime.shadowColor = UIColor.init(hex: "#ffbe53")
                
        currentTime = Date()
        //var dateString: String! = currentTime.stringDateWithFormat("hh:mm")
    }
    
    // MARK: - Actions
    
    override func btnBackClicked(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    func btnSwitchRepeatRingtonClicked() {
        
    }
    
    // MARK: - Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        }
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attributed title is favored if both methods are implemented
    {
        if component == 0 {
            
            var hour: String!
            if row < 10 {
                hour = "0".appending(String(row))
            } else {
                hour = String(row)
            }
            return NSAttributedString.init(string: hour, attributes: [NSForegroundColorAttributeName : UIColor.init(hex: "#ffbe53")])
            
        } else if component == 1 {
            
            var minute: String!
            if row < 10 {
                minute = "0".appending(String(row))
            } else {
                minute = String(row)
            }
            return NSAttributedString.init(string: minute, attributes: [NSForegroundColorAttributeName : UIColor.init(hex: "#ffbe53")])
            
        }
        return NSAttributedString.init(string: "")
    }
    
    // returns width of column and height of row for each component.
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
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
        
        cell.textLabel?.textColor = UIColor.init(hex: "#471601")
        cell.detailTextLabel?.textColor = UIColor.init(hex: "#e7beac")
        
        let bgView: UIView = UIView.init()
        bgView.backgroundColor = UIColor.init(hex: "#ffbe53")
        cell.selectedBackgroundView = bgView
        
        cell.textLabel?.text = arrTitleCell[indexPath.row]
        if indexPath.row != arrTitleCell.count-1 {
            cell.detailTextLabel?.text = arrDetailTitleCell[indexPath.row]
        }
        
        if indexPath.row == 0 || indexPath.row == 1 {
 
            let imvAccessory: UIImageView! = UIImageView.init(image: UIImage.init(named: "next"))
            imvAccessory.contentMode = .scaleAspectFit
            cell.accessoryView = imvAccessory
            
        } else if indexPath.row == 2 {
            
            cell.accessoryType = .none
            
        } else if indexPath.row == 3 {
            
            btnSwitchRepeatRington = UISwitch.init()
            btnSwitchRepeatRington.addTarget(self, action: #selector(ReminderViewController.btnSwitchRepeatRingtonClicked), for: .valueChanged)
            btnSwitchRepeatRington.onTintColor = UIColor.init(hex: "#ffd900")
            cell.accessoryView = btnSwitchRepeatRington
            cell.detailTextLabel?.text = ""
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if indexPath.row == 0 {
            let vc: RepeatViewController! = mainStoryboard.instantiateViewController(withIdentifier: "RepeatViewController") as! RepeatViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            let mediaPicker: MPMediaPickerController! = MPMediaPickerController.init(mediaTypes: .music)
            mediaPicker.delegate = self
            self.present(mediaPicker, animated: true, completion: {})
        }
    }

    // MARK: - MPMediaPickerControllerDelegate
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismiss(animated: true, completion: nil)
        print("you picked: \(mediaItemCollection)")//This is the picked media item.
        //  If you allow picking multiple media, then mediaItemCollection.items will return array of picked media items(MPMediaItem)
    }
}
