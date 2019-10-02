let card : [Card] = [
	Card(color: .hearts, value: .five),
	Card(color: .clubs, value: .five),
	Card(color: .hearts, value: .five),
	Card(color: .spades, value: .king)]

for i in card {
	for j in card {
		print("Card1 -> [\(i.color.rawValue), \(i.value.rawValue)] is", terminator: " ")
		if i.isEqual(j) == false {
			print("not",  terminator: " ")
		} 
		print("equal to Card2 -> [\(j.color.rawValue), \(j.value.rawValue)]")

	}
}
