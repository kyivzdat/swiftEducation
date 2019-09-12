// Initilization
var set1: Set<Int> = [1, 2, 3]
var set2: Set = [4, 5, 6]
var set3 = Set<String>(arrayLiteral: "abc", "def")
var set4 = Set(arrayLiteral: "123", "345")

// Empty
var set5: Set<Int> = []

// Operations and Properties

// .insert(number)
// .remove(number) .removeAll()
// .contains(number)
// .intersection(setX)          спільні дані
// .symetricDifference(setX)    всі неспільні дані
// .union(setX)                 об'єднання
// .subtracting(setX)           входять в перший, але не входять в другий (унікальне в першого)
// .isSubset(of: setX)  .isStrictSubset(of: setX)
// .isSuperset(of: setX)  .isStrictSuperset(of: setX)
// .isDisjoint(with: setX)      чи різні сети

// .sorted() -> return array not set

set4.insert("678")
set4.remove("123")
set4.removeAll()
print(set1.contains(2))

var set6: Set = [1, 3, 5, 7]
var set06: Set = [2, 4, 6, 8]
var set006: Set = [1, 2, 3, 4]
var set0006: Set = [1, 3]

var set7 = set6.intersection(set006).sorted()
var set07 = set6.symmetricDifference(set006).sorted()
var set007 = set6.union(set006).sorted()
var set0007 = set6.subtracting(set006).sorted()

if set0006.isSubset(of: set6) {
    print("set0006 is subset for set6")
}

if (set006.isSuperset(of: set1)) {
    print("set006 is superset for set1")
}

if set6.isDisjoint(with: set06) {
    print("They are different")
}

// isStrictSubset(of: )  isStrictSuperset(of: )

var aset: Set = [1, 2, 3, 4, 5, 6]
var bset: Set = [1, 2, 3, 4, 5, 6]

if aset.isSuperset(of: bset) {
    print("1aset is superset for bset")
}
if aset.isSubset(of: bset) {
    print("2aset is subset for bset")
}

var aset1: Set = [1, 2, 3, 4, 5, 6]
var bset1: Set = [1, 2, 3]

if aset1.isStrictSuperset(of: bset1) {
    print("3aset1 is superset for bset1")
}
if bset1.isStrictSubset(of: aset1){
    print("4bset1 is subset for aset1")
}
