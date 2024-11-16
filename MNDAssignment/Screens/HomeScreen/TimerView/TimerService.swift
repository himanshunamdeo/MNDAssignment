//
//  TimerService.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 16/11/24.
//

import SwiftUI
import Combine

protocol TimerService {
    func startTimer()
    func pauseTimer()
    func resetTimer()
    var timerPublisher: AnyPublisher<Int, Never> { get }
}

class ThrottledTimerService: TimerService {
    
    // Publisher that sends the remaining time to subscribers
    private let timerSubject = PassthroughSubject<Int, Never>()
    private var cancellable: AnyCancellable?
    
    private var startTime: Date?
    private var elapsedTime: Int = 0
    private var remainingTime: Int = TimerConstants.millisecondsInMinute
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    // Timer Publisher
    var timerPublisher: AnyPublisher<Int, Never> {
        timerSubject
            .throttle(for: .milliseconds(10), scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }
    
    // Start the timer
    func startTimer() {
        
        startTime = Date().addingTimeInterval(-Double(elapsedTime))
        LocalNotificationManager.shared.scheduleNotification(timeInterval: TimeInterval(remainingTime/TimerConstants.millisecondsInSecond))
        
        // Register for a background task
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: BackgroundTaskName.timerService) {
            // End the background task if time expires
            self.endBackgroundTask()
        }
        
        // Timer publisher
        cancellable = Timer.publish(every: 0.001, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timerUpdate()
            }
    }
    
    // Pause the timer
    func pauseTimer() {
        LocalNotificationManager.shared.cancelNotification()
        elapsedTime = Int(Date().timeIntervalSince(startTime ?? Date()))
        cancellable?.cancel()
        endBackgroundTask()
    }
    
    // Reset the timer
    func resetTimer() {
        
        LocalNotificationManager.shared.cancelNotification()
        elapsedTime = 0
        remainingTime = TimerConstants.millisecondsInMinute
        cancellable?.cancel()
        endBackgroundTask()
    }
    
    // Called with each time timer is updated
    private func timerUpdate() {
        
        remainingTime -= 1
        // Send the throttled time update
        timerSubject.send(Int(remainingTime))
        
        if remainingTime <= 0 {
            pauseTimer() // Stop the timer when it reaches 0
            remainingTime = TimerConstants.millisecondsInMinute
            LocalNotificationManager.shared.cancelNotification()
            endBackgroundTask()
        }
    }
    
    private func registerBackgroundTask() {
        // Register for a background task
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: BackgroundTaskName.timerService) {
            // End the background task if time expires
            self.endBackgroundTask()
        }
    }
    
    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
