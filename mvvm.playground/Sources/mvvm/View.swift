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

public class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {

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
    }

}

// UITableViewCell class with user interactions

public class Cell: UITableViewCell {

    static let identifier: String = "UITableViewCell"

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

    public func willDisplay(todo: Todo) {
        self.todo = todo
    }

    @objc func switchAction(control: UISwitch) {
        todo?.isDone = control.isOn
    }

}
