import Foundation


//    # Structural Design Patterns
//
//    In software engineering, a design pattern is a general repeatable solution to a commonly occurring problem in software design.
//    A design pattern isn't a finished design that can be transformed directly into code.
//    It is a description or template for how to solve a problem that can be used in many different situations.

// Adapter

struct Row {
    let title: String
}

protocol Target {

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

extension TableAdapter: Target {

    var titleForTable: String? {
        return incompatibleType.first?.title
    }

    var numberOfRowsInTable: Int {
        return incompatibleType.count
    }

    var isRowSelectable: Bool {
        return true
    }
}

let row = [
    Row(title: "first"),
    Row(title: "second"),
    Row(title: "third")
]

let adapter = TableAdapter(row)

// Decorator

protocol Tesla {
    var name: String { get }
    var price: Double { get }
}

class ModelS: Tesla {
    
    var name: String {
        return "Model S"
    }
    
    var price: Double {
        return 94000.00
    }
}

class Model3: Tesla {
    
    var name: String {
        return "Model 3"
    }
    
    var price: Double {
        return 75500.00
    }
    
}

class TeslaDecorator: Tesla {
    var name: String {
        return carInstance.name
    }
    
    var price: Double {
        return carInstance.price
    }
    
    let carInstance: Tesla
    
    init(car: Tesla) {
        self.carInstance = car
    }
}

 class WheelUpgrades: TeslaDecorator {
    
    override var price: Double {
       return carInstance.price + 3000
    }
    
    override var name: String {
        return carInstance.name + " " + "17 in rims"
    }
    
    required override init(car: Tesla) {
        super.init(car: car)
    }
}

var model3: Tesla = Model3()

print(model3.price)
print(model3.name)

model3 = WheelUpgrades(car: model3)
print(model3.price)
print(model3.name)

// Builder

class Burger {
    static let name = "Burger"
}

class Coke {
    static let name = "Coke"
}

class Fries {
    static let name = "Fries"
}

class OrderBuilder {
    
    let contents: [Any]
    
    init(_ contents: [String]) {
        var _contents = [Any]()
        contents.forEach { name in
            switch name {
            case "Burger":
                _contents.append(Burger())
            case "Coke":
                _contents.append(Coke())
            case "Fries":
                _contents.append(Fries())
            default:
                break
            }
        }
        self.contents = _contents
    }
}

let orderBuilder = OrderBuilder(["Burger", "Fries"])
print(orderBuilder.contents)


// Singleton

class FilmDirector {
    static let singleton = FilmDirector()
    
    private init() {
        
    }
}

extension FilmDirector {
    func monitoringBudgets() {
        
    }
    func hostAuditions() {
        
    }
    func overseeingCameraWork() {
        
    }
    func workWithSoundMusic() {
        
    }
}

func preProduction() {
    FilmDirector.singleton.hostAuditions()
    FilmDirector.singleton.monitoringBudgets()
}

func production() {
    FilmDirector.singleton.overseeingCameraWork()
    FilmDirector.singleton.monitoringBudgets()
}

func postProduction() {
    FilmDirector.singleton.workWithSoundMusic()
    FilmDirector.singleton.monitoringBudgets()
}
