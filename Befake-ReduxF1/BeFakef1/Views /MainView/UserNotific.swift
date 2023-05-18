//
//  UserNotific.swift
//  BeFakef1
//
//  Created by Clement Canel on 5/17/23.
//

import SwiftUI
import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        scheduleLocalNotification()
    }
    
    func scheduleLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Hey, it's time to post"
        content.body = "Don't forget to make a post today!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "PostNotification", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
