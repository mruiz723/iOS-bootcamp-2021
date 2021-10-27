import Foundation

//
//    # SOLID
//    - Single Responsibility Principle
//    - Open/Closed Principle
//    - Liskov Substitution Principle
//    - Interface Segregation Principle
//    - Dependency Inversion Principle.
//
//    These principles feed into and support each other and are one of the best general design approaches you could take for your code.
//

// S — Single Responsibility Principle (known as SRP)

struct Student {
    let grade: Int
}

let groupOfStudents: [Student] = [
    Student(grade: 80),
    Student(grade: 90),
    Student(grade: 70),
    Student(grade: 65),
    Student(grade: 90),
    Student(grade: 95)
]

func _averegeGradeOnGroup(students: [Student]) -> Double {
    var total:Int = 0
    let count:Int = students.count
    students.forEach { student in
        total += student.grade
    }
    return Double(total) / Double(count)
}

let _avarege = _averegeGradeOnGroup(students: groupOfStudents)

// Refactor

func sumOfGradesOnGroup(students: [Student]) -> Int {
    var total: Int = 0
    students.forEach { student in
        total += student.grade
    }
    return total
}
func averegeGradeOnGroup(students: [Student]) -> Double {
    let total = Double(sumOfGradesOnGroup(students: students))
    let count = Double(students.count)
    return total / count
}

let avarege = averegeGradeOnGroup(students: groupOfStudents)


// O — Open/Closed Principle

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


// L — Liskov’s Substitution Principle

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

// Refactor


enum AnimalError: Error {
    case cantMakeNoise
}

class DumbDog: Animal {
    override func makeNoise() throws {
        throw AnimalError.cantMakeNoise
    }
}

func makeNoise(animal: DumbDog) {
    do {
        try animal.makeNoise()
    } catch {
        print(error)
    }
}

makeNoise(animal: DumbDog())

// I — Interface Segregation Principle

protocol _onTouchProtocol {
    func onTouch()
    func onLongTouch()
}

class View: _onTouchProtocol {
    func onTouch() {
        
    }
    func onLongTouch() {
        
    }
}

// Refactor

protocol onTouchProtocol {
    func onTouch()
}

protocol onLongTouchProtocol {
    func onLongTouch()
}

class ImageView: onLongTouchProtocol {
    func onLongTouch() {

    }
}

// Interface Segregation Principle

protocol Cacheable {
    func retrieveAccessToken() -> String
}

protocol UserProtocol {
    var accessToken: Cacheable { get }
    func retreiveUserID(completion: (Result<Int, Error>) -> Void)
}

struct KeychainToken: Cacheable {
    func retrieveAccessToken() -> String {
        // get the token from Keychain
        return ""
    }
}

struct FetchUserID: UserProtocol {
    var accessToken: Cacheable

    func retreiveUserID(completion: (Result<Int, Error>) -> Void) {
        // Get the userID using the token
        completion(.success(1234))
    }
}

protocol FetchNewsProtocol {
    var accessToken: Cacheable { get }
    func getNews(completion: (Result<String, Error>) -> Void)
}

protocol FetchProfileProtocol {
    var userID: Int { get }
    func getProfile(completion: (Result<String, Error>) -> Void)
}

struct FetchNews: FetchNewsProtocol {
    var accessToken: Cacheable

    func getNews(completion: (Result<String, Error>) -> Void) {
        // Use the accessToken to retrieve the news
        completion(.success(""))
    }
}

struct FetchProfile: FetchProfileProtocol {
    var userID: Int

    func getProfile(completion: (Result<String, Error>) -> Void) {
        // Use the userID to retreive the profile
        completion(.success(""))
    }
}

// Dependency Inversion Principle

struct User {
    let id: String
    let name: String
}

protocol DatabaseService {
  func getUsers()-> [User]
}

class CoreDataService: DatabaseService {
    func getUsers() -> [User] {
        // Get user from Core Data
        return [User]()
    }
}

class RealmService: DatabaseService {
    func getUsers() -> [User] {
        // Get user from Realm
        return [User]()
    }
}

let databaseService: DatabaseService = CoreDataService()


