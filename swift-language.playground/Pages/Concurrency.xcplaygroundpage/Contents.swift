//: [ErrorHandling](@previous)

import Foundation

// Concurrency

let racers: [String] = ["🐌", "🐢", "🐰", "🏎️", "🚀"]
var results: [String] = []
var place: Int = 1

let group = DispatchGroup()

for racer in racers {
    group.enter()
    DispatchQueue.global().async {
        Thread.sleep(forTimeInterval: TimeInterval.random(in: 1...1.1))
        
        results.append("\(place) place : \(racer)")
        place += 1
        group.leave()
    }
}

group.notify(queue: .main, execute: {
    print(results)
})

// ["1 place : 🐰", "2 place : 🐌", "3 place : 🐢", "4 place : 🚀", "5 place : 🏎️"]



let queue = OperationQueue()

queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🧱")
}
queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🧱")
}
queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🧱")
}
queue.addBarrierBlock {
    print("👷")
}
queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🔨")
}
queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🔨")
}
queue.addOperation {
    Thread.sleep(forTimeInterval: 1)
    print("🔨")
}
queue.addBarrierBlock {
    print("🏠")
}

// 🧱🧱🧱
// 👷
// 🔨🔨🔨
// 🏠
