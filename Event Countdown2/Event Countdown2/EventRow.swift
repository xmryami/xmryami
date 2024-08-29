//
//  EventRow.swift
//  Event Countdown2
//
//  Created by MAC on 8/29/24.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(event.textColor)
            
            Text(timerManager.formattedDate(for: event.date))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .onAppear {
            timerManager.startTimer()
        }
        .onDisappear {
            timerManager.stopTimer()
        }
    }
}
