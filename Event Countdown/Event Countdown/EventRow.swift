//
//  EventRow.swift
//  Event Countdown
//
//  Created by MAC on 9/2/24.
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
            
            Text(timerManager.remainingTime)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .onAppear {
            timerManager.startTimer(for: event.date) // Pass the event date
        }
        .onDisappear {
            timerManager.stopTimer()
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event(id: UUID(), title: "Sample Event", date: Date().addingTimeInterval(86400), textColor: .blue))
    }
}
