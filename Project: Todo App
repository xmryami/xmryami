import Foundation

// MARK: - Todo Structure
// The Todo structure represents a single task with an id, title, and completion status.
struct Todo: Codable, CustomStringConvertible {
    let id: UUID
    var title: String
    var isCompleted: Bool

    // Provides a custom string representation of the Todo, using emojis for status.
    var description: String {
        let statusEmoji = isCompleted ? "✅" : "❌"
        return "\(statusEmoji) \(title)"
    }

    // Initializes a new Todo with a given title, generating a unique id and setting isCompleted to false.
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}

// MARK: - Cache Protocol
// The Cache protocol defines methods for saving and loading Todos.
protocol Cache {
    func save(todos: [Todo])
    func load() -> [Todo]?
}

// MARK: - FileSystemCache Implementation
// FileSystemCache uses the file system to persist and retrieve Todos.
final class JSONFileManagerCache: Cache {
    private let fileName = "todos.json"

    // Saves the list of Todos to a JSON file.
    func save(todos: [Todo]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(todos) {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try? encodedData.write(to: url)
        }
    }

    // Loads the list of Todos from a JSON file.
    func load() -> [Todo]? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            return try? decoder.decode([Todo].self, from: data)
        }
        return nil
    }

    // Helper function to get the URL for the documents directory.
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

// MARK: - InMemoryCache Implementation
// InMemoryCache keeps Todos in memory during the session.
final class InMemoryCache: Cache {
    private var todos: [Todo] = []

    // Saves the list of Todos to memory.
    func save(todos: [Todo]) {
        self.todos = todos
    }

    // Loads the list of Todos from memory.
    func load() -> [Todo]? {
        return todos
    }
}

// MARK: - TodosManager Class
// TodosManager handles the main operations on the Todos list.
final class TodosManager {
    private var todos: [Todo] = []
    private let cache: Cache

    // Initializes TodosManager with a specified cache and loads any existing Todos from the cache.
    init(cache: Cache) {
        self.cache = cache
        if let loadedTodos = cache.load() {
            todos = loadedTodos
        }
    }

    // Lists all Todos in the console.
    func listTodos() {
        if (todos.isEmpty) {
            print("🌟 No todos available!")
        } else {
            print("📝 Listing todos:")
            for (index, todo) in todos.enumerated() {
                print("\(index + 1). \(todo)")
            }
        }
    }

    // Adds a new Todo with the specified title.
    func addTodo(with title: String) {
        let newTodo = Todo(title: title)
        todos.append(newTodo)
        cache.save(todos: todos)
        print("📌 Added new todo: \(newTodo.title)")
    }

    // Toggles the completion status of the Todo at the specified index.
    func toggleCompletion(forTodoAtIndex index: Int) {
        guard index >= 0 && index < todos.count else {
            print("❗ Invalid index!")
            return
        }
        todos[index].isCompleted.toggle()
        cache.save(todos: todos)
        print("🔄 Toggled completion for todo: \(todos[index].title)")
    }

    // Deletes the Todo at the specified index.
    func deleteTodo(atIndex index: Int) {
        guard index >= 0 && index < todos.count else {
            print("❗ Invalid index!")
            return
        }
        let removedTodo = todos.remove(at: index)
        cache.save(todos: todos)
        print("🗑️ Deleted todo: \(removedTodo.title)")
    }
}

// MARK: - App Class
// App handles the main interaction with the user via the console.
final class App {
    private let todosManager: TodosManager

    // Initializes App with a TodosManager.
    init(todosManager: TodosManager) {
        self.todosManager = todosManager
    }

    // Runs the app, awaiting user input and executing commands.
    func run() {
        print("🚀 Welcome to the Todo App!")
        while true {
            print("\nEnter command (add, list, toggle, delete, exit):")
            if let input = readLine(), let command = Command(rawValue: input.lowercased()) {
                switch command {
                case .add:
                    print("Enter todo title:")
                    if let title = readLine() {
                        todosManager.addTodo(with: title)
                    }
                case .list:
                    todosManager.listTodos()
                case .toggle:
                    print("Enter todo index to toggle:")
                    if let indexString = readLine(), let index = Int(indexString) {
                        todosManager.toggleCompletion(forTodoAtIndex: index - 1)
                    }
                case .delete:
                    print("Enter todo index to delete:")
                    if let indexString = readLine(), let index = Int(indexString) {
                        todosManager.deleteTodo(atIndex: index - 1)
                    }
                case .exit:
                    print("👋 Exiting the app. Goodbye!")
                    return
                }
            } else {
                print("❗ Invalid command!")
            }
        }
    }

    // Command enum defines the valid commands for the app.
    enum Command: String {
        case add
        case list
        case toggle
        case delete
        case exit
    }
}

// MARK: - Main Execution
// Set up and run the app with a chosen cache strategy.
let cache = JSONFileManagerCache() // or use InMemoryCache()
let todosManager = TodosManager(cache: cache)
let app = App(todosManager: todosManager)
app.run()
