
print("All spades \u{2660}: ")
for i in Deck.allSpades {
	print("\t\(i)")
}

print("All diamonds \u{2666}: ")
for i in Deck.allDiamonds {
	print("\t\(i)")
}

print("All hearts \u{2665}: ")
for i in Deck.allHearts {
	print("\t\(i)")
}

print("All clubs \u{2663}: ")
for i in Deck.allClubs {
	print("\t\(i)")
}

print("All cards \u{2660}\u{2666}\u{2665}\u{2663}: ")
var counter = 1
for i in Deck.allCards {
	print("\t\(counter): \(i)")
	counter += 1;
}
