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
            
            // capture list with unowned self do not retain self
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

//: [POP](@next)
