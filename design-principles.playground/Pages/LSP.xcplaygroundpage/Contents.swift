//: [OCP](@previous)

import Foundation

//    Liskov’s Substitution Principle
//    Let q(x) be a property provable about objects of x of type T.
//    Then q(y) should be provable for objects y of type S where S is a subtype of T.

enum AnimalError: Error {
    case cantMakeNoise
}

class Animal {
    func makeNoise() throws {
        print("I am making noise")
    }
}

class Dog: Animal {
    override func makeNoise() {
        print("bark bark");
    }
}

class Cat: Animal {
    override func makeNoise() {
        print("meow meow");
    }
}

func _makeNoise(animal: Cat) {
    animal.makeNoise()
}

_makeNoise(animal: Cat())

//: [ISP](@next)
