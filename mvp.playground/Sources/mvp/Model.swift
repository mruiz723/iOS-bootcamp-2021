import Foundation

public struct Model {

    var list: Array<Todo>

    var numberOfTodos: Int {
        list.count
    }

    public init(numberOfTodos: Int) {

        list = []

        for index in 0..<numberOfTodos {
            list.append(Todo(id: index))
        }
    }
    
    public mutating func toggle(index: Int) {
        list[index].isDone = !list[index].isDone
    }

}

public struct Todo {

    let id: Int

    var isDone: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: String(id))
        }
        get {
            UserDefaults.standard.bool(forKey: String(id))
        }
    }

}
