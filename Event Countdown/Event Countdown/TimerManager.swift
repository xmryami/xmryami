//
//  TimerManager.swift
//  Event Countdown
//
//  Created by MAC on 9/2/24.
//

import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var remainingTime: String = ""
    private var timer: Timer?
    private var eventDate: Date?

    func startTimer(for date: Date) {
        eventDate = date
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateRemainingTime()
        }
        updateRemainingTime()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func updateRemainingTime() {
        guard let eventDate = eventDate else { return }
        let remaining = eventDate.timeIntervalSince(Date())
        if remaining > 0 {
            let hours = Int(remaining) / 3600
            let minutes = (Int(remaining) % 3600) / 60
            let seconds = Int(remaining) % 60
            remainingTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            remainingTime = "Event Passed"
        }
    }
}

