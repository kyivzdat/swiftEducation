// Кортеж як вихідних параметр
func getCodeDescription(code: Int)
-> (code: Int, description: String) {
	return (code, description)
}
let request = getCodeDescription(code: 45)
request.description
request.code


// Значення аргументів по замовчуванні
func sumWallet( wallet: [Int]? = nil ) -> Int? {
	return sum
}
sumWallet(wallet: wallet)   // 6 950
sumWallet() 				// nil


// Зовнішні імена аргументів
func sumWallet(banknotsArray wallet: [Int]? = nil ) -> Int? {
	return sum
}
sumWallet(banknotsArray: [50, 100, 100, 500,   50, 1000, 5000, 50, 100])
