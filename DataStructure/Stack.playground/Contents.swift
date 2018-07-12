//: Playground - noun: a place where people can play

import UIKit

class Stack {
    var stack: [Any]
    
    init() {
        stack = [Any]()
    }
    
    func push(_ object: Any) -> Void {
        stack.append(object)
    }
    
    func pop() -> Any? {
        if isEmpty() {
            return nil
        } else {
            return stack.removeLast()
        }
    }
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
    
    func peek() -> Any? {
        return stack.last
    }
    
    func size() -> Int {
        return stack.count
    }
    
    func getArray() -> [Any] {
        return stack
    }
}

func simplifyPath(_ path: String) -> String {
    let stack = Stack()
    
    var res = ""
    let paths = path.characters.split {$0 == "/"}.map(String.init)
    
    for ch in paths {
        let ch = ch.trimmingCharacters(in: CharacterSet.whitespaces)
        guard ch != "." else {
            continue
        }
        
        if ch == ".." {
            if !stack.isEmpty() {
                stack.pop()
            }
        } else {
            stack.push(ch)
        }
    }
    
    for str in stack.getArray() {
        res += "/"
        res += str as! String
    }
    
    return res
}


let path1 = "/a/./b/../../c/"
let afterPath1 = simplifyPath(path1)

let path2 = "/home/"
let afterPath2 = simplifyPath(path2)
















