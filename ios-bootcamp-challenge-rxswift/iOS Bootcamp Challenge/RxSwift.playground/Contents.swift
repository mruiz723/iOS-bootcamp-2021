import UIKit
import RxSwift

let intArrayA: [Int] = [1, 2, 3, 4, 5, 6, 7]
let intArrayB: [Int] = [1, 3, 5, 7]

let bag = DisposeBag()

// First Approach - skip operator
print("---Skip for: \(intArrayA)---n")
let observableA: Observable<Int> = Observable.from(intArrayA)
 observableA.skip { element in
    element < 4
 }.subscribe { element in
    print(element)
 }.disposed(by: bag)

// Antoher Approach - skip operator
print("---Skip for: \(intArrayB)---n")
let observableB: Observable<Int> = Observable.from(intArrayB)
let skip4 = observableB.skip { element in
    element < 4
}

let subscriptionB = skip4.subscribe { element in
    print(element)
}

subscriptionB.disposed(by: bag)

// element(at:) operator
print("---elementAt2 in array: \(intArrayB)---n")
let elementAt2 = observableB.element(at: 2)
elementAt2.subscribe { element in
    print(element)
}
.disposed(by: bag)

// Zip operator

print("---Zip operator---")

let observableC: Observable<Int> = Observable.from([1, 2, 3, 4, 5, 6, 7, 9])
let observableD: Observable<Int> = Observable.from([2, 2, 2, 2, 5, 6, 7])

let zipCD = Observable.zip(observableC, observableD) { $0 * $1 }

zipCD.subscribe { result in
    print(result)
}.dispose()
