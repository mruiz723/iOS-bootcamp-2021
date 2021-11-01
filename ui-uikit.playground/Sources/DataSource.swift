
import UIKit

public class DataSource: NSObject, UITableViewDataSource {
    var numberOfRowsInSection: Int
    let identifiers = [
        "SubtitleCellIdentifier",
        "BasicCellIdentifier"
    ]
    public init(rows: Int) {
        self.numberOfRowsInSection = rows
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSection
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = identifiers[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            fatalError("no class registered identifiere \(identifier)")
        }
        return cell
    }
}
