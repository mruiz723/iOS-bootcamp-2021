import UIKit

public class View: UIViewController {

    public weak var presenter: Presenter?

    public static var cellIdentifier: String {
        Cell.identifier
    }

    public var body: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(Cell.self, forCellReuseIdentifier: View.cellIdentifier)
        return view
    }()

}

// UITableViewCell class with user interactions

public protocol CellDelegate: AnyObject {
    func tableViewCell(_ cell: UITableViewCell, didToggleSwitch control: UISwitch)
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

    public func willDisplay(todo: Todo) {
        self.todo = todo
    }

    @objc func switchAction(control: UISwitch) {
        delegate?.tableViewCell(self, didToggleSwitch: control)
    }

}
