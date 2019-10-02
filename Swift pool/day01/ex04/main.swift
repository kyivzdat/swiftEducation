var arr = Deck(mixed: true)

var x : Card?
for _ in 0...6 {
	x = arr.draw()
}

print("Cards in outs:")
for i in arr.outs {
	print("\t\(i)")
}

for i in 0...2 {
	arr.fold(c: arr.outs[i])
}

print("Cards in outs:")
for i in arr.outs {
	print("\t\(i)")
}

print("Cards in discards:")
for i in arr.discards {
	print("\t\(i)")
}
