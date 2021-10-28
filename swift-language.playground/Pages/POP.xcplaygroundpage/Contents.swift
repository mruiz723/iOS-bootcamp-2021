//: [ARC](@previous)

import Foundation

// Extensions

class Dog {
    let name: String
    init(name: String) {
        self.name = name
    }
}

extension Dog {
    func bark() {
        print("woof woof")
    }
}

let dog = Dog(name: "firulais")
dog.bark()

// Protocol Oriented Programming

protocol Pet {
    var name: String { get }
}

protocol Speak {
    var speakSound: String { get }
    func speak()
}

extension Speak {
    var speakSound: String {
        return "ouch"
    }
    func speak() {
        print("goes \(speakSound)")
    }
}

class DogSpeak: Speak { }

let dogSpeak = DogSpeak()
dogSpeak.speakSound
dogSpeak.speak()

class Cat: Pet, Speak {

    let speakSound: String = "meow"

    let name: String

    init(name: String) {
        self.name = name
    }
    func speak() {
        print("\(name) goes \(speakSound) \(speakSound)")
    }
}

let cat = Cat(name: "Toulouse")

cat.speak()

//: [Generics](@next)

