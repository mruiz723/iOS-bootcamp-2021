import Foundation

// Object-oriented programming (OOP)

// BaseClass
class Animal {
    func speak() {}
}

class LandAnimal: Animal {
    func walk() { }
}
// Child class
class FourLegs: LandAnimal {
    func run() {
        super.walk()
    }
}

class DogAnimal: FourLegs {
    func bark() {
        super.speak() // bubbling
        print("woof")
    }
}
DogAnimal().bark()

// Protocol-Oriented Programming

// Protocols
protocol Speaker {
    func speak()
}
protocol Walker {
    func walk()
}
protocol Runnable {
    func run()
}
protocol Barker {
    func bark()
}

// Client Class
class Dog: Speaker, Walker, Runnable, Barker {
    func speak() {

    }

    func walk() {

    }

    func run() {

    }

    func bark() {
        print("woof")
    }
}
Dog().bark()
