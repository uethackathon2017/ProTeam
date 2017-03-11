//
//  AlarmSchedulerDelegate.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import Foundation

protocol AlarmSchedulerDelegate {
    func setNotificationWithDate(_ date: Date, onWeekdaysForNotify:[Int], snoozeEnabled: Bool, onSnooze:Bool, soundName: String, index: Int)
    func setNotificationWithDate(_ date: Date, onWeekdaysForNotify:[Int], snoozeEnabled: Bool, onSnooze:Bool, soundName: String, index: Int, salutation: String)
    //helper
    func setNotificationForSnooze(snoozeMinute: Int, soundName: String, index: Int)
    func setNotificationForSnooze(snoozeMinute: Int, soundName: String, index: Int, salutation: String)
    func setupNotificationSettings()
    func reSchedule()
}

