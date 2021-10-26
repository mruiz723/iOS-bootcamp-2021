import Foundation

//    ARC - Automatic Reference Counting
//    Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases,
//    this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself.
//    ARC automatically frees up the memory used by class instances when those instances are no longer needed.

class Person {
    let name: String
    var greetings: (() -> String)?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

func example1() {
    let personClass = Person(name: "Timmy")
    print(personClass.name)
}

example1()

func example2() {
    class Chair {
        let person: Person
        init(person: Person) {
            self.person = person
            
            print("Chair with \(self.person.name) is being initialized")
            
            self.person.greetings = { [unowned self] in
                return "Hi, my name is \(self.person.name)."
           }
        }
        deinit {
            print("Chair with \(self.person.name) is being deinitialized")
        }
    }

    let chair = Chair(person: Person(name: "Carlos"))
    if let greetings = chair.person.greetings {
        print(greetings())
    }
}

example2()


// Error Handling (throw, do try catch, error to optional value)

enum SpeakError: Error {
    case cantSpeak
}
struct Speaker {
    func speak() {
        print("hi!")
    }
}

func tryToSpeak(instance: Speaker?) throws {
    if instance == nil {
        throw SpeakError.cantSpeak
    }
    instance?.speak()
}

do {
    try tryToSpeak(instance: nil)
    try tryToSpeak(instance: Speaker())
} catch {
    print(error)
}

// Extension

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

// Generics
//Codable
//Network Layer
//Concurrency (GCD & Operation)
