func printPosFigure(chessman: [Figure]) {
    for i in chessman {
       let (letter, num) = i.pos
       print("Figure - \(i.figure), color - \(i.color), letter - \(letter), num - \(num)")
    }
}

func printFigure(unit: Figure) {
    if unit.color == Chessman.Color.white {
        switch unit.figure {
        case .king:
            print("\u{2654}", terminator: "")
        case .queen:
            print("\u{2655}", terminator: "")
        case .rook:
            print("\u{2656}", terminator: "")
        case .bishop:
            print("\u{2657}", terminator: "")
        case .knight:
            print("\u{2658}", terminator: "")
        case .pawn:
            print("\u{2659}", terminator: "")
        }
    } else {
        switch unit.figure {
        case .king:
            print("\u{265A}", terminator: "")
         case .queen:
            print("\u{265B}", terminator: "")
        case .rook:
            print("\u{265C}", terminator: "")
        case .bishop:
            print("\u{265D}", terminator: "")
        case .knight:
            print("\u{265E}", terminator: "")
        case .pawn:
            print("\u{265F}", terminator: "")
        }  
    }
  
}

func printChessboard(chessman: [Figure]) {
    var white = true
    for y in 1...8 {
        print(y, terminator: " ")
        for x in 1...8 {
            var marker = false
            for figure in chessman {
                let (char, num) = figure.pos
                if  UnicodeScalar(String(char))!.value - 64  == x && num == y {
                    printFigure(unit: figure)
                    white = white == true ? false : true
                    marker = true
                }
            }
            if marker == false {
                white == true ? print("\u{2B1C}", terminator: "") : print("\u{2B1B}", terminator: "")
                white = white == true ? false : true
            }
        }
        print()
    }
    print("  ", terminator: "")
    for character in "abcdefgh" {
        print(character, terminator: " ")
    }
}

enum Chessman : String {

    case pawn = "pawn"
    case knight = "knight"
    case bishop = "bishop"
    case rook = "rook"
    case queen = "queen"
    case king = "king"
        
    enum Color : String {
        case white = "White"
        case black = "Black"
    }
}

typealias Position = (letter: Character, num: Int)
typealias Figure = (figure: Chessman, color: Chessman.Color, pos: Position)

var chessman : [Figure] = []

chessman.append((figure: .knight, color: .black, pos: (letter: "E", num: 1)))
chessman.append((figure: .queen, color: .white, pos: (letter: "G", num: 2)))
chessman.append((figure: .rook, color: .white, pos: (letter: "A", num: 1)))

printPosFigure(chessman: chessman)

printChessboard(chessman: chessman)
