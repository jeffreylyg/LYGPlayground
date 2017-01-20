//: Playground - noun: a place where people can play

import UIKit

protocol Bird {
	var name: String { get }
	var canFly: Bool { get }
}

protocol Flyable {
	var airspeedVelocity: Double { get }
}

extension Bird where Self: Flyable {
    var canFly: Bool {
        return true
    }
}

struct FlappyBird: Bird, Flyable {
	let name: String
	let flappyAmplitude: Double
	let flappyFrequency: Double
	
	var airspeedVelocity: Double {
		return 3 * flappyFrequency * flappyAmplitude
	}
}

struct Penguin: Bird {
	let name: String
	let canFly = false
}

struct SwiftBird: Bird, Flyable {
	var name: String { return "Swift \(version)" }
	let version: Double
 
	// Swift is FAST!
	var airspeedVelocity: Double { return 2000.0 }
}


enum UnladenSwallow: Bird, Flyable {
	case african
	case european
	case unknown
	
	var name: String {
		switch self {
		case .african:
			return "Afican"
		case .european:
			return "European"
		case.unknown:
			return "What do you mean? African or European?"
		}
	}
	
	var airspeedVelocity: Double {
		switch self {
		case .african:
			return 10.0
		case .european:
			return 9.0
		case .unknown:
			fatalError("You are thrown from the bridge of death!")
		}
	}
}

extension Collection {
	func skip(_ skip: Int) -> [Generator.Element] {
		guard skip != 0 else { return [] }
		
		var index = self.startIndex
		var result: [Generator.Element] = []
		var i = 0
		repeat {
			if i % skip == 0 {
				result.append(self[index])
			}
			index = self.index(after: index)
			i += 1
		} while (index != self.endIndex)
		
		return result
	}
}

let bunchaBirds: [Bird] = [UnladenSwallow.african,
                           UnladenSwallow.european,
                           UnladenSwallow.unknown,
                           Penguin(name: "King Penguin"),
                           SwiftBird(version: 2.0),
                           FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0)]

print(bunchaBirds.skip(3))


if UnladenSwallow.african.canFly {
	print("I can fly!")
} else {
	print("Guess I’ll just sit here :[")
}















