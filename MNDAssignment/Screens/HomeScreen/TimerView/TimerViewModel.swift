//
//  TimerViewModel.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    @Published var minute: String = "01"
    @Published var second: String = "00"
    @Published var milliSecond: String = "000"
    @Published var progressTracker: CGFloat = 1.0
    
    private let timerService: TimerService
    private var cancellables = Set<AnyCancellable>()
    private var isStopped = false
    
    init(timerService: TimerService) {
        self.timerService = timerService
        subscribeToTimer()
    }
    
    // Subscribe to the timerservice
    private func subscribeToTimer() {
        timerService.timerPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] timeRemaining in
                if !(self!.isStopped) {
                    
                    // Format text for display
                    self?.minute = self?.formattedMinute(minInInt: timeRemaining - timeRemaining % millisecondsInMinute) ?? "00"
                    self?.second = self?.formattedSecond(secondInInt: ((timeRemaining - timeRemaining % millisecondsInSecond)/millisecondsInSecond)) ?? "00"
                    self?.milliSecond = self?.formattedMillisecond(milliInInt: timeRemaining % millisecondsInSecond) ?? "000"
                    // Update progress tracker
                    self?.progressTracker = CGFloat(timeRemaining) / CGFloat(millisecondsInMinute)
                }
            }
            .store(in: &cancellables)
    }
    
    // Start the timer
    func startTimer() {
        isStopped = false
        timerService.startTimer()
    }
    
    // Stop timer
    func stopTimer() {
        isStopped = true
        timerService.resetTimer()
        reset()
    }
    
    // Pause timer
    func pauseTimer() {
        timerService.pauseTimer()
    }
    
    // Reset the timer texts
    private func reset() {
        minute = "01"
        second = "00"
        milliSecond = "000"
        progressTracker = 1.0
    }
    
    // Formatted minutes up to 2 digits
    private func formattedMinute(minInInt: Int) -> String {
        String(format: "%02d", minInInt)
    }
    
    // Formatted seconds up to 2 digits
    private func formattedSecond(secondInInt: Int) -> String {
        String(format: "%02d", secondInInt)
    }
    
    // Formatted milliseconds up to 3 digits
    private func formattedMillisecond(milliInInt: Int) -> String {
        String(format: "%03d", milliInInt)
    }
}
