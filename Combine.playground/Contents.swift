import Foundation
import Combine

// Built-in publisher NotificationCenter

// we create a custom notification extending the Name struct
extension Notification.Name {
    static let tickingClock = Notification.Name(rawValue: "Clock.notification.ticking")
}

// clock class acts as publisher posting notification with the default notification center
class Clock {

    var seconds: Int = 0

    let notificationCenter = NotificationCenter.default

    /// start incrementing the seconds property and posting the tickingClock notification
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let clock = self else { return }
            clock.seconds += 1
            clock.notificationCenter.post(name: .tickingClock, object: clock)
        })
    }
}

let clock = Clock()

// Publisher
let notificationPublisher = NotificationCenter.Publisher(center: clock.notificationCenter, name: .tickingClock, object: nil)

// Subscriber
let notificationSubscriber = Subscribers.Assign(object: clock, keyPath: \Clock.seconds)

// Operator
let converter = Publishers.Map(upstream: notificationPublisher, transform: { notification -> Int in
    return (notification.object as? Clock)?.seconds ?? 0
})

converter.subscribe(notificationSubscriber)

// Cancellable
// if cancellable is deallocated, the subscription will get cancelled
var reference: Cancellable?
reference = converter.sink(receiveValue: { seconds in
    print(seconds)
    if seconds > 4 {
        reference?.cancel()
//        reference = nil
    }
})

clock.start()

// RUN the clock

// Subscription data-flow
let _ = Just(5) // <Int, Never>
    .map { value -> String in
        // operation with the incoming value here
        // and return a string
        return "a string \(value)"
    }
    .sink { receivedValue in // <String, Never>
        // sink is the subscriber and terminates the pipeline
        print("The end result was \(receivedValue)")
    }
// no need to hold the refernece because it will exceute just once


// RUN Just once


var pokeView  = PokeView()
var publisher = PassthroughSubject<Int, Never>()
var cancellable: AnyCancellable? = nil

cancellable = publisher
    .map { id -> String in
        "https://pokeapi.co/api/v2/pokemon/\(id)"
    }
    .map { string -> URL in
        URL(string: string)!
    }
    .tryMap { url -> Data in
        try Data(contentsOf: url)
    }
    .decode(type: Pokemon.self, decoder: JSONDecoder())
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case .finished:
            print("subscription closes")
            break
        }
    }, receiveValue: { value in
        pokeView.pokemon = value
    })

pokeView.segmentAction = { index in
    publisher.send(index + 1)
}

PreviewWindow(pokeView.view)

// RUN PassthroughSubject

let timer = PassthroughSubject<Bool, Never>()

let cancel = publisher.zip(timer)
    .sink(receiveValue: { a, b in
        print(a, b)
    })

DispatchQueue.global().asyncAfter(deadline: .now() + 5, execute: {
    timer.send(true)
})

// RUN


// Operators functions
// https://heckj.github.io/swiftui-notes/#coreconcepts-operators

// Practical examples for combine
// https://github.com/AvdLee/CombineSwiftPlayground
