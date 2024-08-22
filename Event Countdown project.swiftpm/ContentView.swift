import SwiftUI

// Model for Event
struct Event: Identifiable, Comparable {
    let id: UUID
    var title: String
    var date: Date
    var textColor: Color
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}

// View for a single event row
struct EventRow: View {
    let event: Event
    @State private var currentDate = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(event.title)
                .foregroundColor(event.textColor)
            
            Spacer()
            
            if event.date > currentDate {
                Text(event.date, formatter: RelativeDateTimeFormatter())
                    .onReceive(timer) { input in
                        currentDate = input
                    }
            } else {
                Text("Event Passed")
                    .foregroundColor(.gray)
            }
        }
    }
}

// View for the event list
struct EventsView: View {
    @State private var events: [Event] = []
    @State private var showingForm = false
    @State private var selectedEvent: Event? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(events.sorted()) { event in
                    NavigationLink(destination: EventForm(event: event) { updatedEvent in
                        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                            events[index] = updatedEvent
                        }
                    }) {
                        EventRow(event: event)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingForm) {
                EventForm { newEvent in
                    withAnimation {
                        events.append(newEvent)
                    }
                    showingForm = false
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let eventToDelete = events.sorted()[index]
                if let originalIndex = events.firstIndex(where: { $0.id == eventToDelete.id }) {
                    events.remove(at: originalIndex)
                }
            }
        }
    }
}

// View for the event form
struct EventForm: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var date: Date
    @State private var textColor: Color
    
    var onSave: (Event) -> Void
    var isEditing: Bool
    var eventId: UUID?
    
    init(event: Event? = nil, onSave: @escaping (Event) -> Void) {
        if let event = event {
            _title = State(initialValue: event.title)
            _date = State(initialValue: event.date)
            _textColor = State(initialValue: event.textColor)
            self.isEditing = true
            self.eventId = event.id
        } else {
            _title = State(initialValue: "")
            _date = State(initialValue: Date())
            _textColor = State(initialValue: .black)
            self.isEditing = false
            self.eventId = nil
        }
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Event Title", text: $title)
                    DatePicker("Event Date", selection: $date)
                    ColorPicker("Text Color", selection: $textColor)
                }
            }
            .navigationTitle(isEditing ? "Edit \(title)" : "Add Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEvent = Event(id: eventId ?? UUID(), title: title, date: date, textColor: textColor)
                        onSave(newEvent)
                        dismiss()
                    }
                }
            }
        }
    }
}

// Entry point for the app
struct ContentView: View {
    var body: some View {
        EventsView()
    }
}

