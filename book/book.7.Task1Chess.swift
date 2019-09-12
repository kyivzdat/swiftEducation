typealias Chessman = [String:(alpha: Character, num: Int)?]

var chessmans : Chessman = ["pawn":("a", 5), "bishop":nil, "King":("c", 2)]

func chessAnalizer(figures: Chessman) {
    
    for (figure, pos) in figures {
        if pos != nil {
            print("\(figure) on \(pos!)")
        }
    }
}
chessAnalizer(figures: chessmans)
