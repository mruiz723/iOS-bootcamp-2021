//: [Decorator](@previous)

import Foundation

//    Builder
//    The builder pattern is the process of setting up an object using a dedicated Builder type, rather than by the object itself
//    Require generic function on top of hierarchical structure, treating all complexity of individuals equally

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
    
    var contents: [Any]
    
    init(_ contents: [String]) {
        self.contents = []
        contents.forEach { name in
            switch name {
            case "Burger":
                self.contents.append(Burger())
            case "Coke":
                self.contents.append(Coke())
            case "Fries":
                self.contents.append(Fries())
            default:
                break
            }
        }
    }
}

let order:[Any] = OrderBuilder(["Burger", "Fries"]).contents

print(order)


//    Composite
//    The composite design pattern is a common structural design pattern that composes objects
//    in a tree structure and provides an interface to work with them as they were individual objects.
//    This pattern creates a tree structure with objects inherited from the same base and provides a nice abstraction over the structure.

extension OrderBuilder {
    
    func add(extra: String) -> OrderBuilder {
        let extras = OrderBuilder([extra]).contents
        contents += extras
        return self
    }
    
    func addBurger() -> OrderBuilder {
        add(extra: "Burger")
    }
    
    func addFries() -> OrderBuilder {
        add(extra: "Fries")
    }
    
    func addCoke() -> OrderBuilder {
        add(extra: "Coke")
    }
    
    
}

let orderBuilder = OrderBuilder(["Burger"])
orderBuilder
    .addFries()
    .addFries()
    .add(extra: "Coke")

print(orderBuilder.contents)

//: [Flyweight](@next)
