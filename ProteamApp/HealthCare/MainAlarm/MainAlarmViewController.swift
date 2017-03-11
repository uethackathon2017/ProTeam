//
//  MainAlarmViewController.swift
//  Alarm-ios-swift
//
//  Created by longyutao on 15-2-28.
//  Copyright (c) 2015年 LongGames. All rights reserved.
//

import UIKit

class MainAlarmViewController: BasedTableViewController {
   
    var alarmDelegate: AlarmApplicationDelegate = AppDelegate()
    var alarmScheduler: AlarmSchedulerDelegate = Scheduler()
    var alarmModel: Alarms = Alarms()
    var typeView: Int! // 0. Drink      1. Eat     2. Exercise
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alarmModel = Alarms()
        tableView.reloadData()
        //dynamically append the edit button
        if alarmModel.count != 0 {
            self.navigationItem.leftBarButtonItem = editButtonItem
        }
        else {
            self.navigationItem.leftBarButtonItem = nil
        }
        //unschedule all the notifications, faster than calling the cancelAllNotifications func
        UIApplication.shared.scheduledLocalNotifications = nil
        
        let cells = tableView.visibleCells
        if !cells.isEmpty {
            for i in 0..<cells.count {
                if alarmModel.alarms[i].enabled {
                    (cells[i].accessoryView as! UISwitch).setOn(true, animated: false)
                    cells[i].backgroundColor = UIColor.white
                    cells[i].textLabel?.alpha = 1.0
                    cells[i].detailTextLabel?.alpha = 1.0
                }
                else {
                    (cells[i].accessoryView as! UISwitch).setOn(false, animated: false)
                    cells[i].backgroundColor = UIColor.groupTableViewBackground
                    cells[i].textLabel?.alpha = 0.5
                    cells[i].detailTextLabel?.alpha = 0.5
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action
    
    @IBAction func btnBackClick(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    // Add
    @IBAction func btnAddClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc: ReminderViewController! = mainStoryboard.instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
        vc.segueInfo = SegueInfo(curCellIndex: alarmModel.count, isEditMode: false, label: "Alarm", mediaLabel: "bell", mediaID: "", repeatWeekdays: [], enabled: false)
        self.setTitleWithTypeView(vc)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // Switch Tap
    func switchTapped(_ sender: UISwitch) {
        let index = sender.tag
        alarmModel.alarms[index].enabled = sender.isOn
        if sender.isOn {
            print("switch on")
            sender.superview?.backgroundColor = UIColor.white
            alarmScheduler.setNotificationWithDate(alarmModel.alarms[index].date, onWeekdaysForNotify: alarmModel.alarms[index].repeatWeekdays, snoozeEnabled: alarmModel.alarms[index].snoozeEnabled, onSnooze: false, soundName: alarmModel.alarms[index].mediaLabel, index: index)
            let cells = tableView.visibleCells
            if !cells.isEmpty {
                cells[index].textLabel?.alpha = 1.0
                cells[index].detailTextLabel?.alpha = 1.0
            }
        }
        else {
            print("switch off")
            sender.superview?.backgroundColor = UIColor.groupTableViewBackground
            let cells = tableView.visibleCells
            if !cells.isEmpty {
                cells[index].textLabel?.alpha = 0.5
                cells[index].detailTextLabel?.alpha = 0.5
            }
            alarmScheduler.reSchedule()
        }
    }
    
    func setTitleWithTypeView(_ vc: ReminderViewController!) {
        switch typeView {
        case 0:
            vc.strTitle = "Reminder to Drink"
            break
        case 1:
            vc.strTitle = "Reminder to Eat"
            break
        case 2:
            vc.strTitle = "Reminder to Exercise"
            break
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if alarmModel.count == 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        else {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
        return alarmModel.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isEditing {
            
            let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc: ReminderViewController! = mainStoryboard.instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
            
            vc.segueInfo = SegueInfo(curCellIndex: indexPath.row, isEditMode: true, label: alarmModel.alarms[indexPath.row].label, mediaLabel: alarmModel.alarms[indexPath.row].mediaLabel, mediaID: alarmModel.alarms[indexPath.row].mediaID, repeatWeekdays: alarmModel.alarms[indexPath.row].repeatWeekdays, enabled: alarmModel.alarms[indexPath.row].enabled)
            
            self.setTitleWithTypeView(vc)

            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Id.alarmCellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: Id.alarmCellIdentifier)
        }
        //cell text
        cell!.selectionStyle = .none
        cell!.tag = indexPath.row
        let alarm: Alarm = alarmModel.alarms[indexPath.row]
        let amAttr: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 20.0)]
        let str = NSMutableAttributedString(string: alarm.formattedTime, attributes: amAttr)
        let timeAttr: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 45.0)]
        str.addAttributes(timeAttr, range: NSMakeRange(0, str.length-2))
        cell!.textLabel?.attributedText = str
        cell!.detailTextLabel?.text = alarm.label
        //append switch button
        let sw = UISwitch(frame: CGRect())
        sw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
        
        //tag is used to indicate which row had been touched
        sw.tag = indexPath.row
        sw.addTarget(self, action: #selector(MainAlarmViewController.switchTapped(_:)), for: UIControlEvents.touchUpInside)
        if alarm.enabled {
            sw.setOn(true, animated: false)
        }
        cell!.accessoryView = sw
        
        //delete empty seperator line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell!
    }
    
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            alarmModel.alarms.remove(at: index)
            let cells = tableView.visibleCells
            for cell in cells {
                let sw = cell.accessoryView as! UISwitch
                //adjust saved index when row deleted
                if sw.tag > index {
                    sw.tag -= 1
                }
            }
            if alarmModel.count == 0 {
                self.navigationItem.leftBarButtonItem = nil
            }
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            alarmScheduler.reSchedule()
        }   
    }
    
    @IBAction func unwindFromAddEditAlarmView(_ segue: UIStoryboardSegue) {
        isEditing = false
    }

}

