import UIKit
import RxSwift
import RxCocoa

let intArrayA: [Int] = [1, 2, 3, 4, 5, 6, 7]
let intArrayB: [Int] = [1, 3, 5, 7]

let bag = DisposeBag()

// First Approach - skip operator
print("---Skip for: \(intArrayA)---\n")
let observableA: Observable<Int> = Observable.from(intArrayA)
 observableA.skip { element in
    element < 4
 }.subscribe { element in
    print(element)
 }.disposed(by: bag)

// Antoher Approach - skip operator
print("---Skip for: \(intArrayB)---\n")
let observableB: Observable<Int> = Observable.from(intArrayB)
let skip4 = observableB.skip { element in
    element < 4
}

let subscriptionB = skip4.subscribe { element in
    print(element)
}

subscriptionB.disposed(by: bag)

// element(at:) operator
print("---elementAt2 in array: \(intArrayB)---\n")
let elementAt2 = observableB.element(at: 2)
elementAt2.subscribe { element in
    print(element)
}
.disposed(by: bag)

// Zip operator

print("---Zip operator---\n")

let observableC: Observable<Int> = Observable.from([1, 2, 3, 4, 5, 6, 7, 9])
let observableD: Observable<Int> = Observable.from([2, 2, 2, 2, 5, 6, 7])

let zipCD = Observable.zip(observableC, observableD) { $0 * $1 }

zipCD.subscribe { result in
    print(result)
}.dispose()

/*
 RxSwift

 Observable (sequence) - emits events (notifications of change) asyncronously
 Observer - subscribes to Observable in order to receive events


 Subject = Observable + Observer
    - PublishSubject. Only emits new elements to subscribers
    - BehaviorSubject. Emits the last element to new subscribers
    - ReplaySubject. Emits a buffer size of elements to new subscribers
    - AsyncSubject. Emits only the las next event in the sequence, and
                    only when the subject receives a completed event.

 Relays = Wrapper around Subjects that they never emit onComplete and onError event.
    Great for UI related work
    - Publish Relay
    - Behavior Relay
 */

/* PublishSubject */
print("---PublishSubject---\n")
let publishSubject = PublishSubject<String>()
publishSubject.onNext("Hi iOS Bootcamp")

let observer1 = publishSubject.subscribe(onNext: { element in
    print(element)
})

publishSubject.onNext("Hey iOS Bootcamp!!!")
observer1.dispose()

/* BehaviorSubject */
print("---BehaviorSubject---\n")
let behaviorSubject = BehaviorSubject<String>(value: "Hi Behavior Subject")

let observer2 = behaviorSubject.subscribe(onNext: { element in
    print(element)
})

behaviorSubject.onNext("Hey Behavior Subject!!!")
observer2.dispose()

/* ReplaySubject */
print("---ReplaySubject---\n")
let replaySubject = ReplaySubject<Int>.create(bufferSize: 3)
replaySubject.onNext(0)
replaySubject.onNext(1)
replaySubject.onNext(7)
replaySubject.onNext(2)
replaySubject.onNext(3)

let observer3 = replaySubject.subscribe(onNext: { element in
    print(element)
})

observer3.dispose()
replaySubject.onNext(7)

/* AsyncSubject */
print("---AsyncSubject---\n")
let asyncSubject = AsyncSubject<String>()
asyncSubject.onNext("Hello")
asyncSubject.onNext("Hey Team!")

let observer4 = asyncSubject.subscribe(onNext: { element in
    print(element)
})

asyncSubject.onCompleted()
observer4.dispose()

/* PublishRelay */
print("---PublishRelay---\n")
let publishRelay = PublishRelay<String>()
publishRelay.accept("Surprise!!!")

let observer5 = publishRelay.subscribe(onNext: { element in
    print(element)
})

publishRelay.accept("Wow, Only emits new elements to subscribers!!!")
observer5.dispose()

/* BehaviorRelay */
print("---BehaviorRelay---\n")
let behaviorRelay = BehaviorRelay<String>(value: "Emits the last element to new subscribers")

let observer6 = behaviorRelay.subscribe(onNext: { element in
    print(element)
})

behaviorRelay.accept("Surprise!!!")
observer6.dispose()
