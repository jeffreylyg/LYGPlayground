//: Playground - noun: a place where people can play

import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
    
    init(_ some: T) {
        self = .success(some)
    }
    
    init(_ error: Error) {
        self = .failure(error)
    }
    
    func map<U>(_ f: (T) -> U) -> Result<U> {
        switch self {
        case let .success(value):
            return .success(f(value))
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func flatten<T>(_ f: Result<Result<T>>) -> Result<T> {
        switch f {
        case let .success(value):
            return value;
        case let .failure(error):
           return .failure(error)
        }
    }
    
    func flatMap<U>(_ f: (T) -> Result<U>) -> Result<U> {
        return flatten(map(f))
    }
}

let a = Result<String>("aa")
let b = a.flatMap { (e) -> Result<Int> in
    return Result<Int>(10)
}.map { (e) -> UIColor in
    return UIColor.white
}.map { (color) -> CGColor in
    return color.cgColor
}
print(b)




