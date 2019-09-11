var i : Int?
var j : Int
i = 5
i = nil
var str = Optional("String")
print(str)
// if str != nil {
//     var str2 = str!
// } else {
//     var str2 = str
// }
// print(str2)

if str != nil {
    print(str!)
} else {
    print(str)
}

var coordPoint : (x: Int, y: Int)? = (4, 2)
print(coordPoint)
print(coordPoint!)