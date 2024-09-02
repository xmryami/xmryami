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
    let onDelete: ((Event) -> Void)? // Optional delete callback
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
        NavigationStack {
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
                    if case .edit = mode {
                        Button("Save") {
                            let updatedEvent = Event(id: UUID(), title: title, date: date, textColor: textColor)
                            onSave(updatedEvent)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if case .delete(let event) = mode, let onDelete = onDelete {
                        Button("Delete") {
                            onDelete(event)
                            dismiss()
                        }
                        .foregroundColor(.red)
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
        case .delete(let event):
            return "Delete \(event.title)"
        }
    }
}
