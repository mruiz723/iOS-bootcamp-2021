//: [Adapter](@previous)

import Foundation

//    Decorator
//    The idea of the Decorator pattern is responsibilities should be added to (and removed from) an object dynamically at run-time.
//    Therefore, it is a flexible alternative to subclassing for extending functionality should be provided
                                                                                                                                                                                            
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

class WheelUpgrade: TeslaDecorator {
    
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

class SunroofUpgrade: TeslaDecorator {
    
    override var price: Double {
       return carInstance.price + 4000
    }
    
    override var name: String {
        return carInstance.name + " " + "w/sunroof"
    }
    
    required override init(car: Tesla) {
        super.init(car: car)
    }
}

var model3: Tesla = Model3()

print(model3.name, model3.price) // Model 3 75500.0

model3 = WheelUpgrade(car: model3)

print(model3.name, model3.price) // Model 3 17 in rims 78500.0

model3 = SunroofUpgrade(car: model3)

print(model3.name, model3.price) // Model 3 17 in rims w/sunroof 82500.0

//: [Builder](@next)
