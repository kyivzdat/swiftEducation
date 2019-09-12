typealias Chessman = [String:(alpha: Character, num: Int)?]

var chessmans : Chessman = ["pawn":("a", 5), "bishop":nil, "King":("c", 2)]

func chessChangePos
(_ chessmans: inout Chessman, _ figure: String, pos: (Character, Int)?) {
    if chessmans[figure] == nil {
        chessmans[figure] = pos
    } else {
        chessmans[figure] = pos
    }
}

print(chessmans)
chessChangePos(&chessmans, "bishop", pos: ("c", 5))
chessChangePos(&chessmans, "queen", pos: ("g", 3))
print(chessmans)
