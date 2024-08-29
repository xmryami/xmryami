//
//  TimerManager.swift
//  Event Countdown2
//
//  Created by MAC on 8/29/24.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @Published var currentDate: Date = Date()
    private var timer: Timer?
    
    func startTimer() {
        // Ensure we are on the main thread to avoid UI updates issues
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.currentDate = Date()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func formattedDate(for eventDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter.localizedString(for: eventDate, relativeTo: currentDate)
    }
}
