import UIKit

public struct View {

    public var viewModel: ViewModel

    public static var cellIdentifier: String {
        Cell.identifier
    }

    public var body: TableView = {
        let view = TableView(frame: .zero, style: .insetGrouped)
        view.register(Cell.self, forCellReuseIdentifier: View.cellIdentifier)
        view.delegate = view
        view.dataSource = view
        return view
    }()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.body.viewModel = viewModel
    }

}

// UITableView class with delegates

public class TableView: UITableView, UITableViewDelegate, UITableViewDataSource, CellDelegate {

    var viewModel: ViewModel?

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: View.cellIdentifier)!
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let todo = viewModel?.getTodo(at: indexPath), let cell = (cell as? Cell) else { return }
        cell.willDisplay(todo: todo)
        cell.delegate = self
    }

    public func tableViewCell(_ cell: UITableViewCell, didToggle control: UISwitch) {
        guard let indexPath = self.indexPath(for: cell) else { return }
        viewModel?.didToggleTodosSwitch(index: indexPath.row)
    }
}

// UITableViewCell class with user interactions

public struct TodoElement {
    let name: String
    let isCompleted: Bool
}

public protocol CellDelegate: AnyObject {
    func tableViewCell(_ cell: UITableViewCell, didToggle control: UISwitch)
}

public class Cell: UITableViewCell {

    static let identifier: String = "UITableViewCell"

    public weak var delegate: CellDelegate?

    var todo: Todo? {
        didSet {
            guard let todo = todo else { return }
            textLabel?.text = "To-do \(todo.id)"
            switchView?.isOn = todo.isDone
        }
    }

    lazy var switchView: UISwitch? = {
        let switchView = UISwitch()
        addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switchView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        switchView.addTarget(self, action: #selector(switchAction(control:)), for: .primaryActionTriggered)
        return switchView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("error")
    }

    func viewDidLoad() {
        selectionStyle = .none
        accessoryView = switchView
    }

    public func willDisplay(todo: TodoElement) {
        textLabel?.text = todo.name
        switchView?.isOn = todo.isCompleted
    }

    @objc func switchAction(control: UISwitch) {
        delegate?.tableViewCell(self, didToggle: control)
    }

}
