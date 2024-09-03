//
//  EventsView.swift
//  Event Countdown
//
//  Created by MAC on 9/2/24.
//

import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = [
        Event(id: UUID(), title: "Sample Event 1", date: Date().addingTimeInterval(86400), textColor: .blue),
        Event(id: UUID(), title: "Sample Event 2", date: Date().addingTimeInterval(172800), textColor: .red)
    ]
    @State private var selectedEvent: Event?
    @State private var isNavigatingToForm = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(events) { event in
                    NavigationLink(
                        destination: EventForm(event: event, mode: .edit(event), onSave: { updatedEvent in
                            if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                                events[index] = updatedEvent
                            }
                        }),
                        tag: event,
                        selection: $selectedEvent
                    ) {
                        EventRow(event: event)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            if let index = events.firstIndex(where: { $0.id == event.id }) {
                                events.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EventForm(event: Event(id: UUID(), title: "", date: Date(), textColor: .black), mode: .add, onSave: { newEvent in
                        events.append(newEvent)
                    })) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
