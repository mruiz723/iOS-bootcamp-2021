import Foundation

public class ViewModel {

    var model: Model

    public init(model: Model) {
        self.model = model
    }

    // Interpreter
    var numberOfRowsInSection: Int {
        model.numberOfTodos
    }

    // Intents
    func getTodo(at indexPath: IndexPath) -> TodoElement {
        let todo = model.list[indexPath.row]
        return TodoElement(name: "Todo: \(todo.id)", isCompleted: todo.isDone)
    }

    func didToggleTodosSwitch(index: Int) {
        model.toggle(index: index)
    }

}
