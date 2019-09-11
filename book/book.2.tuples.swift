var tuple = (1, "str", true)
print(tuple.0)

var tuple2 : (Int, String, Bool)
tuple2.0 = 3
print(tuple2.0)
tuple2 = (5, "str2", false)
print(tuple2)

var (integer, string, bool) = tuple
print(integer)

var (i, s) = (15, "swift")
print(i, s)

var tuple3 = (i, s)
print(tuple3)

var (variable, _, _) = tuple
print(variable)

var tuple4 = (var1: 15, var2:"swift")
print(tuple4.var1, tuple4.var2)

var tuple5 : (var1: Int, var2: String)
tuple5 = tuple3
print(tuple5)