//
//  EventForm.swift
//  Event Countdown
//
//  Created by MAC on 8/26/24.
//

import SwiftUI

struct EventForm: View {
    @State private var title: String
    @State private var date: Date
    @State private var textColor: Color
    let onSave: (Event) -> Void
    @Environment(\.dismiss) private var dismiss

    init(event: Event, onSave: @escaping (Event) -> Void) {
        _title = State(initialValue: event.title)
        _date = State(initialValue: event.date)
        _textColor = State(initialValue: event.textColor)
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    ColorPicker("Title Color", selection: $textColor)
                }
            }
            .navigationTitle(title.isEmpty ? "Add Event" : "Edit \(title)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let updatedEvent = Event(id: UUID(), title: title, date: date, textColor: textColor)
                        onSave(updatedEvent)
                        dismiss()
                    }
                }
            }
        }
    }
}
