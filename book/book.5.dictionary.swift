// initialisation

// Dictionary(uniqueKeysWithValues: collection)
// Dictionary(uniqueKeysWithValues: zip(collect1, collect2))

var dict1 = ["one":1, "two":2]

let collection = [(1, 5), (2, 6), (3, 7)]
let newDictionary = Dictionary(uniqueKeysWithValues: collection)

let names = ["Alex", "Michael", "Carl"]
let ages = [15, 19, 24]
var profile = Dictionary(uniqueKeysWithValues: zip(names, ages))

// empty

var empty : [String:Int] = [:]
var empty2 : Dictionary<String,Int> = [:]
var empty3 = Dictionary<String,Int>()

// Operations and Properties

// .updateValue( , forKey: )
// .removeValue(forKey: )
// .count .isEmpty
// .keys .values -> return LazyMapCollection

profile["Alex"] = 28
profile["Peter"] = 20
profile.updateValue(41, forKey: "Alex")
profile.updateValue(21, forKey: "Cavin")
profile.removeValue(forKey: "Alex")
profile["Cavin"] = nil
print(profile.keys)
print(profile.values)
