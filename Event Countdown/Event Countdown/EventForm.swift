//
//  EventForm.swift
//  Event Countdown
//
//  Created by MAC on 9/2/24.
//


import SwiftUI

enum FormMode {
    case add
    case edit(Event)
    case delete(Event)
}

struct EventForm: View {
    @State private var title: String
    @State private var date: Date
    @State private var textColor: Color
    let onSave: (Event) -> Void
    let onDelete: ((Event) -> Void)?
    @Environment(\.dismiss) private var dismiss
    private let mode: FormMode

    init(event: Event, mode: FormMode, onSave: @escaping (Event) -> Void, onDelete: ((Event) -> Void)? = nil) {
        _title = State(initialValue: event.title)
        _date = State(initialValue: event.date)
        _textColor = State(initialValue: event.textColor)
        self.onSave = onSave
        self.onDelete = onDelete
        self.mode = mode
    }
    
    var body: some View {
        Form {
            Section(header: Text("Event Details")) {
                TextField("Event Title", text: $title)
                    .foregroundColor(textColor)
                
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
                Button(action: saveAction, label: {
                    Label("Save", systemImage: "square.and.arrow.down")
                })
                .disabled(title.isEmpty)
            }
        }
    }

    private var navigationTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit(let event):
            return "Edit \(event.title)"
        case .delete:
            return "Delete Event"
        }
    }

    private func saveAction() {
        switch mode {
        case .add:
            let newEvent = Event(id: UUID(), title: title, date: date, textColor: textColor)
            onSave(newEvent)
        case .edit(var updatedEvent):
            updatedEvent.title = title
            updatedEvent.date = date
            updatedEvent.textColor = textColor
            onSave(updatedEvent)
        case .delete(let event):
            onDelete?(event)
        }
        dismiss()
    }
}

