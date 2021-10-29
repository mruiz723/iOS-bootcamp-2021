import Foundation

//    Structural Design Patterns
//
//    In software engineering, a design pattern is a general repeatable solution to a commonly occurring problem in software design.
//    A design pattern isn't a finished design that can be transformed directly into code.
//    It is a description or template for how to solve a problem that can be used in many different situations.

//    Adapter
//    Adapter is a structural design pattern that allows objects with incompatible interfaces to work together.
//    In other words, it transforms the interface of an object to adapt it to a different object.

struct Row {
    let title: String
}

let rows: [Row] = [
    Row(title: "first"),
    Row(title: "second"),
    Row(title: "third")
]

protocol Table {

    var titleForTable: String? { get }

    var numberOfRowsInTable: Int { get }

    var isRowSelectable: Bool { get }
}

class TableAdapter {

    private let incompatibleType: [Row]

    init(_ incompatibleType: [Row]) {
        self.incompatibleType = incompatibleType
    }
}

extension TableAdapter: Table {

    var titleForTable: String? {
        return incompatibleType.first?.title
    }

    var numberOfRowsInTable: Int {
        return incompatibleType.count
    }

    var isRowSelectable: Bool {
        return false
    }
}

// this method only uses Table interface to work with
func displayTableInfo(_ table: Table) {
    if let name = table.titleForTable {
        print(name)
    }
    print("contain \(table.isRowSelectable ? "selectable":"non-selectable") \(table.numberOfRowsInTable) rows")
}

// we use the adapter to work with the incompatible type. eg [Row]
let tableAdapter = TableAdapter(rows)

displayTableInfo(tableAdapter)

//: [Decorator](@next)
