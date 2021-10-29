//: [Builder](@previous)

import Foundation


//    Singleton
//    Singletons to provide a globally accessible, shared instance of a class.
//    You can create your own singletons as a way to provide a unified access point to a resource or service that’s shared across an app,
//    like an audio channel to play sound effects or a network manager to make HTTP requests.

class Singleton {
    
    // swift static instances are lazy initialized
    static let shared = Singleton()
    
    static let sharedWithConfiguration: Singleton = {
        let instance = Singleton()
        // setup code
        instance.name = "Shared instance across application"
        return instance
    }()
    
    var name: String
    
    private init() {
        self.name = "(no-name)"
    }
}

print(Singleton.shared.name)

print(Singleton.sharedWithConfiguration.name)


//    Flyweight
//    Flyweight is a structural design pattern that allows programs
//    to support vast quantities of objects by keeping their memory consumption low.
//    handle the configuration and management of instances

class FilmDirector {
    
    public init() {
        print("initialization of FilmDirector")
    }
    func monitoringBudgets() {
        
    }
    func hostAuditions() {
        
    }
    func overseeingCameraWork() {
        
    }
    func workWithSoundMusic() {
        
    }
}

class Flyweight {
    // private singleton and initialization for factory
    private static let singleton = Flyweight()
    private init() {}
    
    private var directors: [String: FilmDirector] = [:]
    
    // only point of access for client classes
    static func directorFor(_ movie: String) -> FilmDirector {
        let singleton = Self.singleton
        
        if let director = singleton.directors[movie] {
            return director
        } else {
            let director = FilmDirector()
            singleton.directors[movie] = director
            
            return director
        }
    }
}

let movie = "Back to the future IV"

func preProduction() {
    print("pre production")
    Flyweight.directorFor(movie).hostAuditions()
    Flyweight.directorFor(movie).monitoringBudgets()
}

func production() {
    print("production")
    Flyweight.directorFor(movie).overseeingCameraWork()
    Flyweight.directorFor(movie).monitoringBudgets()
}

func postProduction() {
    print("post production")
    Flyweight.directorFor(movie).workWithSoundMusic()
    Flyweight.directorFor(movie).monitoringBudgets()
}

preProduction()     // pre production
                    // initialization of FilmDirector
production()        // production
postProduction()    // post production

