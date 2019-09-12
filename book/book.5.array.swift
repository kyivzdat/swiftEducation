var arr = Array(arrayLiteral: "a", "b", "c", "d", "e")
var arr1 = Array(1...15)
var arr01 = Array(arrayLiteral: 1, 2, 3, 4, 5)
var arr2 = Array(repeating: "q", count: 3)
var arr3 = [1, 2, 3]
arr1[0...3] = [0]
arr[0...2] = ["o"]

// Type directly
var arr4: [String] = ["abc", "dce"]

// Empty arr
var arr5: [Int] = []
var arr6 = [Int]()

var arr7 = [String?](repeating: nil, count: 5)

var arr8 = arr + arr2
arr += arr2

// Operations and Properties

// .count
// .isEmpty
// .suffix(numberOf)
// .first .last
// .append(number) .insert(number, at: index)
// .remove(at: ) .removeFirst .removeLast
// For constant: .dropFirst(numberof) .dropLast()
// .contains(number) true/false
// .index(of: )
// .min() .max()
// .reversed() !! var arr14: [Int] = arr9.reversed() || [Int]arr9.reversed() !! <- return new collection
// .reverse() <- reverse collection it self

print(arr3.count)
print("\(arr3.isEmpty)\n\(arr5.isEmpty)")
var arr9 = Array(0...20)
var arr10 = arr9[0...arr9.count-12] // 0...9
var arr11 = arr10.suffix(3) // 7, 8, 9 Returns a subsequence from the specified position to the end of the collection.
print(arr11)
var arr12 = arr10.first!    // 0
arr12 = arr10.last!         // 9

// arr5 = []
var arr13 = arr5.first          // nil
arr5.append(1)                  // 1 New element at the end
arr5.insert(2, at: arr5.count)  // 1, 2
arr9.insert(11, at: 2)          // 0, 1, 11, 2 ...
arr9.remove(at: 2)              // 0, 1, 2 ...

let constArr = [1, 2, 3]
var newArr = constArr.dropFirst()   // 2, 3

print(arr9.contains(4))             //true
print(arr9.index(of: 4))            //optional(4)
print(arr9.min())                   // 0
print(arr9.max())                   // 20
// arr = ["o", "d", "e", "q", "q", "q"]
print(arr.min())                    // d
print(arr9)
var arr14: [Int] = arr9.reversed()
arr9.reverse()
print(arr9)
print(arr14)
