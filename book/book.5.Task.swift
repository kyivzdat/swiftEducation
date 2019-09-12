typealias Chessman = [String:(alpha: Character, num: Int)?]

var chessmans : Chessman = ["pawn":("a", 5), "bishop":nil, "King":("c", 2)]

if let coord = chessmans["pawn"]! {
    print("Pawn is on \(coord)")
}
if let coord = chessmans["bishop"]! {
    print("Bishop is on \(coord)")
}
if let coord = chessmans["King"]! {
    print("King is on \(coord)")
}
