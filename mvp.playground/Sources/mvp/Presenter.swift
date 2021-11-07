import UIKit

public class Presenter: NSObject {

    private var model: Model

    private var viewController: View

    public init(model: Model, view: View) {
        self.model = model
        self.viewController = view
    }

    public var view: UIView {
        let view = self.viewController.body
        view.delegate = self
        view.dataSource = self
        return view
    }
}

extension Presenter: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.numberOfTodos
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: View.cellIdentifier)!
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = (cell as? Cell) else { return }
        let todo = self.model.list[indexPath.row]
        cell.willDisplay(todo: todo)
        cell.delegate = self
    }

}

extension Presenter: CellDelegate {
    public func tableViewCell(_ cell: UITableViewCell, didToggleSwitch control: UISwitch) {
        guard let indexPath = self.viewController.body.indexPath(for: cell) else { return }
        self.model.toggle(index: indexPath.row)
    }

    public func toggle(index: Int) {
        self.model.toggle(index: index)
    }
}
