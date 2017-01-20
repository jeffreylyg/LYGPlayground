//: Playground - noun: a place where people can play

import UIKit

func reverse(_ x: Int) -> Int {
	var num = x
	while num % 10 == 0 {
		num = num / 10
	}
	
	var result = 0
	while num != 0 {
		let c = num % 10
		result = result * 10 + c
		num = num / 10
		
		if result > Int(Int32.max) || result < Int(Int32.min) {
			return 0
		}
	}
	
	return result
}

func isPalindrome(_ x: Int) -> Bool {
	guard x >= 0 else {
		return false
	}
	
	var num = x
	var div = 1
	while num / div >= 10 {
		div = div * 10
	}
	
	while num > 0 {
		let left = num / div
		let right = num % 10
		if left != right {
			return false
		}
		
		num = (num % div) / 10
		div = div / 100
	}
	
	return true
}

func myPow(_ x: Double, _ n: Int) -> Double {
	if n == 0 { return 1 }
	if n == 1 { return x }
	
	var count = n
	if n < 0 { count = -n }
	
	let temp = myPow(x, count / 2)
	var result: Double
	if count % 2 == 0 {
		result = temp * temp
	} else {
		result = temp * temp * x
	}
	
	if n < 0 {
		return 1 / result
	}
	
	return result
}