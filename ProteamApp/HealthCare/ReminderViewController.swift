//
//  ReminderViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import MediaPlayer

class ReminderViewController: SettingViewController, RepeatViewControllerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    var alarmScheduler: AlarmSchedulerDelegate = Scheduler()
    var alarmModel: Alarms = Alarms()
    var segueInfo: SegueInfo!
    var snoozeEnabled: Bool = false
    var enabled: Bool!
    
    var mediaItem: MPMediaItem?
    var mediaID: String!
    
    var arrDetailTitleCell = ["Monday, Friday", "Nơi này có anh", "Time to exercises, Vinh !"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.firstInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        alarmModel = Alarms()
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - First Init
    
    func firstInit() {
        
        lblTitle.text = strTitle
        datePicker.datePickerMode = .time
        
        arrTitleCell = ["Repeat", "Rington", "Salutation", "Repeat Rington"]
        
        datePicker.tintColor = UIColor.init(hex: "#FFA613")
        datePicker.shadowColor = UIColor.init(hex: "#FFA613")
        
    }
    
    override func btnBackClicked(_ sender: Any) {
        super.btnBackClicked(sender)
        
        let date = datePicker.date
        let index = segueInfo.curCellIndex
        var tempAlarm = Alarm()
        tempAlarm.date = date
        tempAlarm.label = segueInfo.label
        tempAlarm.enabled = segueInfo.enabled
        tempAlarm.mediaLabel = segueInfo.mediaLabel
        tempAlarm.mediaID = segueInfo.mediaID
        tempAlarm.snoozeEnabled = snoozeEnabled
        tempAlarm.repeatWeekdays = segueInfo.repeatWeekdays
        tempAlarm.uuid = UUID().uuidString
        if segueInfo.isEditMode {
            alarmModel.alarms[index] = tempAlarm
        }
        else {
            alarmModel.alarms.append(tempAlarm)
        }
    }
    
    override func btnSwitchRepeatRingtonClicked(_ sender: UISwitch) {
        snoozeEnabled = sender.isOn
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UITableViewCell")
        }
        
        cell.textLabel?.textColor = UIColor.init(hex: "#471601")
        cell.detailTextLabel?.textColor = UIColor.init(hex: "#e7beac")
        
        let bgView: UIView = UIView.init()
        bgView.backgroundColor = UIColor.init(hex: "#FFA613")
        cell.selectedBackgroundView = bgView
        
        cell.textLabel?.text = arrTitleCell[indexPath.row]
        
        if indexPath.row != arrTitleCell.count - 1 {
            cell.detailTextLabel?.text = arrDetailTitleCell[indexPath.row]
        }
        
        if indexPath.row == 0 || indexPath.row == 1 {
 
            let imvAccessory: UIImageView! = UIImageView.init(image: UIImage.init(named: "next"))
            imvAccessory.contentMode = .scaleAspectFit
            cell.accessoryView = imvAccessory
            
            if indexPath.row == 0 {
                cell!.detailTextLabel!.text = RepeatViewController.repeatText(weekdays: segueInfo.repeatWeekdays)
            } else {
                cell!.detailTextLabel!.text = segueInfo.mediaLabel
            }
            
        } else if indexPath.row == 2 {
            
            cell.accessoryType = .none
            
        } else if indexPath.row == 3 {
            
            let btnSwitchRepeatRington:UISwitch = UISwitch()
            btnSwitchRepeatRington.addTarget(self, action: #selector(ReminderViewController.btnSwitchRepeatRingtonClicked(_ :)), for: .valueChanged)
            btnSwitchRepeatRington.onTintColor = UIColor.init(hex: "#ffd900")
            cell.accessoryView = btnSwitchRepeatRington
            cell.detailTextLabel?.text = ""
            if snoozeEnabled {
                btnSwitchRepeatRington.setOn(true, animated: false)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if indexPath.row == 0 {
            let vc: RepeatViewController! = mainStoryboard.instantiateViewController(withIdentifier: "RepeatViewController") as! RepeatViewController
            vc.weekdays = segueInfo.repeatWeekdays
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            
            let mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
            mediaPicker.delegate = self
            mediaPicker.allowsPickingMultipleItems = false
            self.present(mediaPicker, animated: true, completion: nil)

        } else if indexPath.row == 2 {
            
        }
     }
    
    
    // MARK: - RepeatViewControllerDelegate
    
    func backWithObject(_ obj: AnyObject) {
        
        let src = obj as! RepeatViewController
        segueInfo.repeatWeekdays = src.weekdays
    }
    
}

extension ReminderViewController: MPMediaPickerControllerDelegate {
    
    // MARK: - MPMediaPickerControllerDelegate
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        if !mediaItemCollection.items.isEmpty {
            let aMediaItem = mediaItemCollection.items[0]
            
            segueInfo.mediaLabel = aMediaItem.title!
            //mediaID = (aMediaItem.value(forProperty: MPMediaItemPropertyPersistentID)) as! String
        }
        self.dismiss(animated: true, completion: nil)
        print("you picked: \(mediaItemCollection)")//This is the picked media item.
        //  If you allow picking multiple media, then mediaItemCollection.items will return array of picked media items(MPMediaItem)
    }
}
