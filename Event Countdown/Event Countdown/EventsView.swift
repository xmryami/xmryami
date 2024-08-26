//
//  EventsView.swift
//  Event Countdown
//
//  Created by MAC on 8/26/24.
//

import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = [
        // Example events
        Event(id: UUID(), title: "Sample Event 1", date: Date().addingTimeInterval(86400), textColor: .blue),
        Event(id: UUID(), title: "Sample Event 2", date: Date().addingTimeInterval(172800), textColor: .red)
    ]
    
    @State private var isPresentingEventForm = false
    @State private var eventToEdit: Event?

    var body: some View {
        NavigationStack {
            List {
                ForEach(events) { event in
                    NavigationLink(destination: EventForm(event: event, onSave: { updatedEvent in
                        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                            events[index] = updatedEvent
                        }
                    })) {
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
                    Button(action: {
                        eventToEdit = nil
                        isPresentingEventForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingEventForm) {
                EventForm(event: eventToEdit ?? Event(id: UUID(), title: "", date: Date(), textColor: .black), onSave: { newEvent in
                    if let index = events.firstIndex(where: { $0.id == newEvent.id }) {
                        events[index] = newEvent
                    } else {
                        events.append(newEvent)
                    }
                })
            }
        }
    }
}
