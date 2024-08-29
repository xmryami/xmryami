//
//  EventForm.swift
//  Event Countdown2
//
//  Created by MAC on 8/29/24.
//

import SwiftUI

enum FormMode {
    case add
    case edit(Event)
}

struct EventForm: View {
    @State private var title: String
    @State private var date: Date
    @State private var textColor: Color
    let onSave: (Event) -> Void
    @Environment(\.dismiss) private var dismiss
    private let mode: FormMode

    init(event: Event, mode: FormMode, onSave: @escaping (Event) -> Void) {
        _title = State(initialValue: event.title)
        _date = State(initialValue: event.date)
        _textColor = State(initialValue: event.textColor)
        self.onSave = onSave
        self.mode = mode
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    
                    ColorPicker("Title Color", selection: $textColor)
                }
            }
            .navigationTitle(navigationTitle)
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

    private var navigationTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit(let event):
            return "Edit \(event.title)"
        }
    }
}

