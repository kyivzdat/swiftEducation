import Foundation

class Deck : NSObject {
	static let allSpades : [Card] = Value.allValues.map({Card(color: .spades, value: $0)})
	static let allDiamonds : [Card] = Value.allValues.map({Card(color: .diamonds, value: $0)})
	static let allHearts : [Card] = Value.allValues.map({Card(color: .hearts, value: $0)})
	static let allClubs : [Card] = Value.allValues.map({Card(color: .clubs, value: $0)})
	static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs

	var cards = allCards
	var discards : [Card] = []
	var outs : [Card] = []

	override var description : String {
		return self.cards.description
	}

	init(mixed: Bool) {
		if mixed == true {
			self.cards.shuffle()
		}
	}

	func draw() -> Card? {
		if self.cards.count > 0 {
			self.outs.append(self.cards[0])
			self.cards.removeFirst()
			return self.outs[self.outs.count - 1]
		}
		return nil
	}

	func fold(c: Card) {
		if self.outs.contains(c) == true {
			self.discards.append(c)
			var index = 0
			for i in outs {
				if i == c {
					self.outs.remove(at: index)
					break ;
				}
				index += 1
			}
		}
	}
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
