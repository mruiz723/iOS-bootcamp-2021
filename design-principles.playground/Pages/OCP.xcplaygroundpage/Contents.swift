//: [SRP](@previous)

import Foundation

//    Open/Closed Principle
//    Objects or entities should be open for extension but closed for modification.

protocol Shape {
    var area: Double { get }
}

struct Rectangle: Shape {
    var width: Double
    var height: Double
}

struct Circle: Shape {
    var radius: Double
}

func _totalAreaFor(shapes: [Shape]) -> Double {
    var area: Double = 0
    
    shapes.forEach { shape in
        if let rectangle = shape as? Rectangle {
            area += rectangle.width * rectangle.height
        }
        if let circle = shape as? Circle {
            area += circle.radius * circle.radius * Double.pi
        }
    }
    
    return area
}

let _area = _totalAreaFor(shapes: [Rectangle(width: 10, height: 10), Circle(radius: 10)])

// Refactor

extension Rectangle {
    var area: Double {
        return width * height
    }
}

extension Circle {
    var area: Double {
        return radius * radius * Double.pi
    }
}

func totalAreaFor(shapes: [Shape]) -> Double {
    var area: Double = 0
    
    shapes.forEach { shape in
        area += shape.area
    }
    
    return area
}

let area = totalAreaFor(shapes: [Rectangle(width: 10, height: 10), Circle(radius: 10)])

//: [LSP](@next)
