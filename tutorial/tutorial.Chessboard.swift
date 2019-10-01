func printPosFigure(chessman: [Figure]) {
    for i in chessman {
       let (letter, num) = i.pos
       print("Figure - \(i.figure), color - \(i.color), letter - \(letter), num - \(num)")
    }
}

func printFigure(unit: Figure) {
    switch (unit.figure, unit.color, unit.pos) {
        case (.king, .white, _):
            print("\u{2654}", terminator: "")
        case (.king, .black, _):
            print("\u{265A}", terminator: "")
        case (.queen, .white, _):
            print("\u{2655}", terminator: "")
        case (.queen, .black, _):
            print("\u{265B}", terminator: "")
        case (.rook, .white, _):
            print("\u{2656}", terminator: "")
        case (.rook, .black, _):
            print("\u{265C}", terminator: "")
        case (.bishop, .white, _):
            print("\u{2657}", terminator: "")
        case (.bishop, .black, _):
            print("\u{265D}", terminator: "")
        case (.knight, .white, _):
            print("\u{2658}", terminator: "")
        case (.knight, .black, _):
            print("\u{265E}", terminator: "")
        case (.pawn, .white, _):
            print("\u{2659}", terminator: "")
        case (.pawn, .black, _):
            print("\u{265F}", terminator: "")
    }
}

func moveFigure(chessman: inout [Figure], unit: Figure, pos: (char: Character, num: Int)) {
    var exist = false
    // var i = 0
    // for _ in chessman {
    //     let (figure, color, _) = chessman[i]
    //     if figure == unit.figure && color == unit.color {
    //         exist = true
    //         break 
    //     }
    //     i += 1
    // }
    let i = chessman.index(where: {
        (figure: Chessman, color: Chessman.Color, _) -> Bool in
        exist = true
        return figure == unit.figure && color == unit.color
    })!
    if exist == false {
        print("Figure doesn't exist")
        return
    }
    let collision = chessman.contains(where: {
        (figure: Chessman, color: Chessman.Color, position: (char: Character, num: Int)) -> Bool in
        return (figure != unit.figure || color != unit.color) &&
        position == pos
    })
    let (char, num) = pos
    if UnicodeScalar(String(char))!.value - 64 < 1 || UnicodeScalar(String(char))!.value - 64 > 8
	|| num < 1 || num > 8 || collision == true {
        print("Wrong coordinates")
        return
    }
    chessman[i] = (figure: unit.figure, color: unit.color, pos: (letter: char, num: num))
}

// func printFigure(unit: Figure) {
//     if unit.color == Chessman.Color.white {
//         switch unit.figure {
//             case .king:
//                 print("\u{2654}", terminator: "")
//             case .queen:
//                 print("\u{2655}", terminator: "")
//             case .rook:
//                 print("\u{2656}", terminator: "")
//             case .bishop:
//                 print("\u{2657}", terminator: "")
//             case .knight:
//                 print("\u{2658}", terminator: "")
//             case .pawn:
//                 print("\u{2659}", terminator: "")
//         }
//     } else {
//         switch unit.figure {
//             case .king:
//                 print("\u{265A}", terminator: "")
//              case .queen:
//                 print("\u{265B}", terminator: "")
//             case .rook:
//                 print("\u{265C}", terminator: "")
//             case .bishop:
//                 print("\u{265D}", terminator: "")
//             case .knight:
//                 print("\u{265E}", terminator: "")
//             case .pawn:
//                 print("\u{265F}", terminator: "")
//         }  
//     }
// }

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

chessman.append((figure: .king, color: .black, pos: (letter: "E", num: 1)))
chessman.append((figure: .queen, color: .white, pos: (letter: "G", num: 2)))
chessman.append((figure: .rook, color: .white, pos: (letter: "A", num: 1)))

printPosFigure(chessman: chessman)

moveFigure(chessman: &chessman, unit: chessman[2], pos: (char: "B", num: 1))

printChessboard(chessman: chessman)