//: [ErrorHandling](@previous)

import Foundation

// Concurrency

//    DispatchGroup
//    Groups allow you to aggregate a set of tasks and synchronize behaviors on the group.
//    You attach multiple work items to a group and schedule them for asynchronous execution on the same queue or different queues.
//    When all work items finish executing, the group executes its completion handler.
//    You can also wait synchronously for all tasks in the group to finish executing.

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

//    OperationQueue
//    An operation queue invokes its queued Operation objects based on their priority and readiness.
//    After you add an operation to a queue, it remains in the queue until the operation finishes its task.
//    You can’t directly remove an operation from a queue after you add it.

//    Note:
//    Operation queues retain operations until the operations finish, and queues themselves are retained until all operations are finished.
//    Suspending an operation queue with operations that aren’t finished can result in a memory leak.

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
