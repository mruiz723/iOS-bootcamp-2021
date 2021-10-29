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

//    Single Responsibility Principle (known as SRP)
//    A class should have one and only one reason to change, meaning that a class should have only one job.

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

//: [OCP](@next)
