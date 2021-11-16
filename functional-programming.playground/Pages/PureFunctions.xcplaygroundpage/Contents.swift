import Foundation

//    Functional Programming
//    It is a declarative programming paradigm in which function definitions
//    are trees of expressions that map values to other values,
//    rather than a sequence of imperative statements which update the running state of the program.

//    Pure Functions
//    Subset of functional programming in which the
//    functions are mathematically deterministic

var foo: Double = 1.123

// should not rely on outside values to produce a return value
func getDecimals(num: Double) -> Double {
    // data should be unmutable
    foo = floor(foo)

    // The output of the function should only depents of the inputs
    return num - foo
//    transform the input
//    return num.truncatingRemainder(dividingBy: 1)
}

let bar = getDecimals(num: foo)

print(bar)

// functional code should produce no "side effects"
print(foo)


// Higher-order functions (function as arguments)

let getHappyFace: () -> String = {
    ["😀", "😄", "😆", "🙂", "😉"].shuffled().first!
}

print(getHappyFace()) // 😄

let appendHappyFace: ((String) -> String) = { string in
    return string + " 😃 "
}

print(appendHappyFace("hi")) // hi 😃

let appendEmoji: ( String, (() -> String) ) -> String = { string, emoji in
    return string + " \(emoji()) "
}

print(appendEmoji("hi", getHappyFace)) // hi 😉

// reusability

let names: [String] = ["John", "Mark", "Tom"]

let printNames: ([String], ((String) -> String)) -> Void = { strings, modifier in
    print("\nlist of names:")
    for string in strings {

        let modifiedString = modifier(string)

        print(modifiedString)

    }

}

printNames(names, appendHappyFace)

// modifiers

let modifierModifier: (@escaping ((String, (() -> String)) -> String), String) -> ((String) -> String) = { modifier, prop in
    return { string in modifier(string, { prop }) }
}

let namesModifier: (([String], @escaping ((String, (() -> String)) -> String), String) -> (() -> Void)) = { strings, modifier, emoji in
    return { printNames(names, modifierModifier(modifier, emoji)) }
}

let printModifiedNames: (() -> Void) = namesModifier(names, appendEmoji, "😮")

printModifiedNames()
