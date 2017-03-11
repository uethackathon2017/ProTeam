//
//  AppDelegate.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Google
import GoogleSignIn
import AudioToolbox
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, AVAudioPlayerDelegate, AlarmApplicationDelegate, NotificationViewControllerDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?
    let alarmScheduler: AlarmSchedulerDelegate = Scheduler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        // Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Google
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        // Local Notification
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        alarmScheduler.setupNotificationSettings()
        window?.tintColor = UIColor.init(hex: "#FFA613")
        
        return true
    }
    
    // Local Notification
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        var soundName: String = ""
        if let userInfo = notification.userInfo {
            soundName = userInfo["soundName"] as! String
        }
        playSound(soundName)
        let mainSb: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc: NotificationViewController! = mainSb.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.delegate = self
        vc.notification = notification
        window?.rootViewController!.present(vc, animated: true, completion: nil)
    }
    
    //snooze notification handler when app in background
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        if identifier == Id.snoozeIdentifier {
            var soundName: String = ""
            var index: Int = -1
            if let userInfo = notification.userInfo {
                soundName = userInfo["soundName"] as! String
                index = userInfo["index"] as! Int
            }
            alarmScheduler.setNotificationForSnooze(snoozeMinute: 9, soundName: soundName, index: index)
        }
        completionHandler()
    }
    
    //print out all registed NSNotification for debug
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
        print(notificationSettings.types.rawValue)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // FB
        let handler: Bool! = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handler
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let source = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else { return false }
        let annotation = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: source, annotation: annotation)
        
        //    return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Facebook
        FBSDKAppEvents.activateApp()
        
        // Google
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - GIDSignInDelegate
    
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // [START_EXCLUDE]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
            // [END_EXCLUDE]
        }
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    // [END disconnect_handler]
    
    // MARK: - AlarmApplicationDelegate protocol
    func playSound(_ soundName: String) {
        
        //vibrate phone first
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        //set vibrate callback
        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
                                              nil,
                                              { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
                                                print("callback", terminator: "") //todo
        },
                                              nil)
        let url = URL(
            fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
        
        var error: NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        if let err = error {
            print("audioPlayer error \(err.localizedDescription)")
        } else {
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
        }
        //negative number means loop infinity
        audioPlayer!.numberOfLoops = -1
        audioPlayer!.play()
    }
    
    //MARK: - AVAudioPlayerDelegate protocol, todo
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
    }
    
    //MARK: - NotificationViewControllerDelegate
    func repeatClicked(notification: UILocalNotification, vc: NotificationViewController) {
        var isSnooze: Bool = false
        var soundName: String = ""
        var index: Int = -1
        if let userInfo = notification.userInfo {
            isSnooze = userInfo["snooze"] as! Bool
            soundName = userInfo["soundName"] as! String
            index = userInfo["index"] as! Int
        }
        //schedule notification for snooze
        if isSnooze {
            alarmScheduler.setNotificationForSnooze(snoozeMinute: 9, soundName: soundName, index: index)
            self.audioPlayer?.stop()
        }
        // Dismiss NotificationViewController
        vc.dismiss(animated: true, completion: nil)
    }
    
    func shutDownClicked(notification: UILocalNotification, vc: NotificationViewController) {
        var index: Int = -1
        if let userInfo = notification.userInfo {
            index = userInfo["index"] as! Int
        }
        
        self.audioPlayer?.stop()
        let vc = self.window?.rootViewController as! UINavigationController
        var mainVC: MainAlarmViewController
        
        // Turn off cell notificationed
        for viewController in vc.viewControllers {
            if viewController.isKind(of: MainAlarmViewController.self) {
                mainVC = viewController as! MainAlarmViewController
                if mainVC.alarmModel.alarms[index].repeatWeekdays.isEmpty {
                    mainVC.alarmModel.alarms[index].enabled = false
                }
                let cells = mainVC.tableView.visibleCells
                for cell in cells {
                    if cell.tag == index {
                        let sw = cell.accessoryView as! UISwitch
                        if mainVC.alarmModel.alarms[index].repeatWeekdays.isEmpty {
                            sw.setOn(false, animated: false)
                            cell.backgroundColor = UIColor.groupTableViewBackground
                            cell.textLabel?.alpha = 0.5
                            cell.detailTextLabel?.alpha = 0.5
                        }
                    }
                }
            }
        }
        
        // Dismiss NotificationViewController
        vc.dismiss(animated: true, completion: nil)
    }
}

