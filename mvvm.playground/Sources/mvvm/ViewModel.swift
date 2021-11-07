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
    func getTodo(at indexPath: IndexPath) -> Todo {
        model.list[indexPath.row]
    }

    func didToggleTodosSwitch(index: Int) {
        model.toggle(index: index)
    }

}
