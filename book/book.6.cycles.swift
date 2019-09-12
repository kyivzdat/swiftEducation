// (1...10).reversed()
// stride(from: 1, to/through: 1o, by: 2)
// .enumereted() -> get index from array
// break/continue point (point -> random name)

var summa = 0

for i in 1...10 {
    summa += i
}

for i in (1...10).reversed() {
    summa += i
}

// 1...11
for i in stride(from: 1, through: 11, by: 2) {
    summa += i
     print(i)
}

// 1..<11
for i in stride(from: 1, to: 11, by: 2) {
     print(i)
}

let dictionary = [1:"One", 2:"Two", 3:"Three"]

for (num, word) in dictionary {
    print("\(num) write like \(word)")
}

var arr = ["a", "b", "c"]
for (num, char) in arr.enumerated() {
    print("\(num + 1). Char - \(char)")
}

var str = "Hello"
for i in str {
    print(i)
}

var resultOfGames = ["Manchester":["2:1", "3:1"], "Dynamo":["1:1", "1:0"]]
for (team, result) in resultOfGames {
    print("\(team) play game with score ", terminator: "")
    for game in result {
        print(game, terminator: ", ")
    }
    print()
}

point: for i in 0...10 {
    for y in 0...5 {
        if i == 2 && y == 1 {
            print("point")
            break point
        }
    }
}
