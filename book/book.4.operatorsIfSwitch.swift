import Foundation

typealias Text = String
let var1 : Text
let var2 : Text
let var3 : Text

var1 = "123"
var2 = "abc"
var3 = "1ab2"
var var4 = Int(var1)

// Bad way
if var4 == Int(var1) {
    print("Int") // +
} else {
    print("Not Int")
}
if var4 == Int(var2) {
    print("Int")
} else {
    print("Not Int") // + 
}

// Good
if var var5 = Int(var1) {
    print("Int - \(var5)") // +
}
if var var5 = Int(var2) {
    print("Int - \(var5)")
}
if var var5 = Int(var3) {
    print("Int - \(var5)")
}

// Or

if Int(var1) != nil {
    print("Int - \(var1)") // +
}
if Int(var2) != nil {
    print("Int - \(var2)")
}
if Int(var3) != nil {
    print("Int - \(var3)")
}

typealias TupleType = (numberOne : Text?, numberTwo : Text?)?

var n1 : TupleType = ("190", "67")
var n2 : TupleType = ("10", nil)
var n3 : TupleType = ("-35", "64")
var n4 : TupleType = nil

if let (one, two) = n1 {
    if one != nil && two != nil {
        print(one!, two!);
    }
}
if let (one, two) = n2 {
    if one != nil && two != nil {
        print(one!, two!);
    }
}
if let (one, two) = n3 {
    if one != nil && two != nil {
        print(one!, two!);
    }
}
if let (one, two) = n4 {
    if one != nil && two != nil {
        print(one!, two!);
    }
}

typealias Operation = (operandOne: Float, operandTwo: Float, operandThree: Character)

let const: Operation = (3.1, 33, "-")

switch const {
    case (_, _, "+"):
        print(const.0 + const.1)
        break;
    case (_, _, "-"):
        var a = const.0 - const.1
        print(a)
        break;
    case (_, _, "*"):
        print(const.0 * const.1)
        break;
    case (_, _, "/"):
        print(const.0 / const.1)
        break;
    default:
        print("!")
}
