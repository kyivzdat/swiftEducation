import Foundation
import Darwim

var maxInt = Int.max
var minInt = Int.min
var maxFlt = FLT_MAX
var maxDbl = DBL_MAX

print("maxInt = \(maxInt)")
print("minInt = \(minInt)")

let varInt = 1
let varDbl : Double = 2.7
let varFlt = 3.5

var sum1 : Int = Int(Double(varInt) + varDbl + Double(varFlt))
var sum2 : Double = Double(varInt) + varDbl + Double(varFlt)
var sum3  = Float(varInt) + Float(varDbl) + Float(varFlt)

print("1 = \(sum1)\n2 = \(sum2)\n3 = \(sum3)")

if sum3 > Float(sum1) {
    print("3 > 1")
} else {
    print("3 < 1")
}

sum3 > Float(sum1) ? print("3 > 1") : print("3 < 1")

print(sum3 > Float(sum1) ? "3 > 1" : "3 < 1")
