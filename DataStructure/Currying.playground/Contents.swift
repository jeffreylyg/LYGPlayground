//: Playground - noun: a place where people can play

import UIKit

//MARK: Currying
func addTo(adder: Int) -> (Int) -> Int {
    return {
        num in
        return num + adder
    }
}
let addTwo = addTo(adder: 2)
print(addTwo(4))


func greaterThan(comparer: Int) -> (Int) -> Bool {
    return { num in
        return num > comparer
    }
}

let greaterThan10 = greaterThan(comparer: 10)
print(greaterThan10(13))
print(greaterThan10(9))



//MARK: Tail Recursive
func sum(n: UInt) -> UInt {
    if n == 0 {
        return 0
    }
    return n + sum(n: n - 1)
}

sum(n: 100)

func tailSum(n: UInt) -> UInt {
    func sumInternal(n: UInt, current: UInt) -> UInt {
        if n == 0 {
            return current
        } else {
            return sumInternal(n: n - 1, current: n + current)
        }
    }
    
    return sumInternal(n: n, current: 0)
}

//tailSum(n: 10000000)

