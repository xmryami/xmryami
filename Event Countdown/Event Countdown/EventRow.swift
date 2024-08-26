//
//  EventRow.swift
//  Event Countdown
//
//  Created by MAC on 8/26/24.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    @State private var timer: Timer?

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(event.textColor)
            Text(formattedDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private var formattedDate: String {
        let formatter = RelativeDateTimeFormatter()
        return formatter.localizedString(for: event.date, relativeTo: Date())
    }

    private func startTimer() {
        // Invalidate existing timer if any
        timer?.invalidate()

        // Create a new timer that fires every minute
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            // Trigger view update
            // This line ensures the view is refreshed every minute
            UIApplication.shared.windows.first?.rootViewController?.view.setNeedsDisplay()
        }
    }
}
