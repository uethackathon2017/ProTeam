//
//  DrinkViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DrinkViewController: MainAlarmViewController, IndicatorInfoProvider {

    @IBOutlet weak var imvMinute: UIImageView!
    @IBOutlet weak var imvSec: UIImageView!
    @IBOutlet weak var imvHour: UIImageView!
    
    var angleSec: CGFloat! = 0
    var angleHour: CGFloat! = 0
    var angleMinute: CGFloat! = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        angleSec = 0
        angleMinute = 0
        angleHour = 0
        
        // Init
        
        self.navigationController?.navigationBar.isHidden = true
        
        let date = Date()
        let hour = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)
        let seconds = Calendar.current.component(.second, from: date)
        
        for _ in 0..<(hour%12) {
            self.actionWithImageView(self.imvHour, angle: 6, delay: 0, type: 3)
        }
        for _ in 0...minutes {
            self.actionWithImageView(self.imvMinute, angle: 30, delay: 0, type: 2)

        }
        for _ in 0...(seconds+30) {
            self.actionWithImageView(self.imvSec, angle: 30, delay: 0, type: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            while true {
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    self.actionWithImageView(self.imvSec, angle: 30, delay: 1, type: 1)
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            while true {
                Thread.sleep(forTimeInterval: 60)
                DispatchQueue.main.async {
                    self.actionWithImageView(self.imvMinute, angle: 30, delay: 1, type: 2)
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            while true {
                Thread.sleep(forTimeInterval: 3600)
                DispatchQueue.main.async {
                    self.actionWithImageView(self.imvHour, angle: 6, delay: 1, type: 3)
                }
            }
        }
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    // Menu
    @IBAction func btnMenuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
   
    
    
    // Clock
    // Type: 1. Second  2. Minute   3. Hour
    
    func actionWithImageView(_ imageView: UIImageView, angle:Double, delay: TimeInterval, type: Int) {
        
        UIView.animate(withDuration: 0, delay: delay, options: .curveLinear, animations: {
            if type == 1 {
                self.angleSec = self.angleSec + CGFloat(M_PI/angle)
                imageView.transform = CGAffineTransform.init(rotationAngle: self.angleSec)
                if self.angleSec == CGFloat(2*M_PI) {
                    self.angleSec = 0
                }
            } else if type == 2 {
                self.angleMinute = self.angleMinute + CGFloat(M_PI/angle)
                imageView.transform = CGAffineTransform.init(rotationAngle: self.angleMinute)
                if self.angleMinute == CGFloat(2*M_PI) {
                    self.angleMinute = 0
                }
            } else {
                self.angleHour = self.angleHour + CGFloat(M_PI/angle)
                imageView.transform = CGAffineTransform.init(rotationAngle: self.angleHour)
                if self.angleHour == CGFloat(2*M_PI) {
                    self.angleHour = 0
                }
            }
            
        }) { (finished) in
            
        }
        
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        let amAttr: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0)]
        let str = NSMutableAttributedString(string: alarm.formattedTime, attributes: amAttr)
        let timeAttr: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 25.0)]
        str.addAttributes(timeAttr, range: NSMakeRange(0, str.length-2))
        cell!.textLabel?.attributedText = str
        cell?.textLabel?.textColor = UIColor.white
        cell?.detailTextLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont.init(name: "UTM-Neo-Sans-Intel", size: 25)
        cell!.detailTextLabel?.text = alarm.label
        cell?.backgroundColor = UIColor.clear
        
        // custom separator
        
        let separator: UIView! = UIView.init(frame: CGRect.init(x: 0, y: self.tableView.bounds.size.height-1.5, width: self.tableView.bounds.size.width, height: 1.5))
        separator.addShadow(CGSize.init(width: 1, height: 1), radius: 0, color: UIColor.white, opacity: 0.29)
        
        //append switch button
        let sw = UISwitch(frame: CGRect())
        sw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
        sw.backgroundColor = UIColor.clear
        sw.onTintColor = UIColor.init(hex: "#FFD900")
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
}
