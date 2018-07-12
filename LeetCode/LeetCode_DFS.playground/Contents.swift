//: Playground - noun: a place where people can play

import UIKit

/* 394. Decode String */
func decodeString(_ s: String) -> String {
	var result = ""
	var countStr = ""
	var numStack: [Int] = []
	var strStack: [String] = []
	for ch in s {
		switch ch {
		case "0"..."9":
			countStr += String(ch)
		case "[":
			let count = Int(countStr)!
			numStack.append(count)
			countStr = ""
			
			strStack.append(result)
			result = ""
		case "]":
			let count = numStack.removeLast()
			print(strStack)
			var last = strStack.last!
			for _ in 0..<count {
				last += result
			}
			result = last
			strStack.removeLast()
		default:
			result += String(ch)
		}
	}
	
	return result
}

print("result: \(decodeString("3[a2[b2[c]]]"))")
