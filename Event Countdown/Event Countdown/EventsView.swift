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
                    NavigationLink(value: event) {
                        EventRow(event: event)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationDestination(for: Event.self) { event in
                EventForm(event: event, mode: .edit(event), onSave: { updatedEvent in
                    if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                        events[index] = updatedEvent
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: Event(id: UUID(), title: "", date: Date(), textColor: .black)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventForm(event: event, mode: .add, onSave: { newEvent in
                    events.append(newEvent)
                })
            }
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}


    

