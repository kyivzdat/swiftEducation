typealias Chessman = [String:(alpha: Character, num: Int)?]

var chessmans : Chessman = ["pawn":("a", 5), "bishop":nil, "King":("c", 2)]

for (figure, pos) in chessmans {
    if pos != nil {
        print("\(figure) on \(pos!)")
    }
}
