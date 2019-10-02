import Foundation

class Deck : NSObject {
	static let allSpades : [Card] = Value.allValues.map({Card(color: .spades, value: $0)})
	static let allDiamonds : [Card] = Value.allValues.map({Card(color: .diamonds, value: $0)})
	static let allHearts : [Card] = Value.allValues.map({Card(color: .hearts, value: $0)})
	static let allClubs : [Card] = Value.allValues.map({Card(color: .clubs, value: $0)})
	static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
	mutating func shuffle() {
		for i in 0..<self.count {
			let index = Int(arc4random_uniform(UInt32(self.count)))
			if i != index {
				let tmp = self[i]
				self[i] = self[index]
				self[index] = tmp
			}
		}
	}
}
