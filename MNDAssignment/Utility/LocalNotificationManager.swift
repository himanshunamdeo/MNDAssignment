//
//  LocalNotificationManager.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 16/11/24.
//

import Foundation

import UserNotifications

class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Complete"
        content.body = "Your countdown timer has finished!"
        content.sound = .default
        
        // Create a trigger to fire the notification when the timer ends
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: "timerComplete", content: content, trigger: trigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerComplete"])
    }
}
