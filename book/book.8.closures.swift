func getInfo(wallet: [Int], closer: (Int) -> Bool) -> [Int] {
    var res : [Int] = []
    for money in wallet {
        if closer(money) {
            res.append(money)
        }
    }
    return res
}

func get100(money: Int) -> Bool {
    return money == 100
}

func getMore100(money: Int) -> Bool {
    return money > 100
}

var wallet = [10,50,100,100,5000,100,50,50,500,100]

print(getInfo(wallet: wallet, closer: get100))
print(getInfo(wallet: wallet, closer: getMore100))

print(getInfo(wallet: wallet, closer: {(money: Int) -> Bool in
return money == 100}))
print(getInfo(wallet: wallet, closer: {(money: Int) -> Bool in return money > 100}))

print(getInfo(wallet: wallet, closer: {money in return money == 100}))
print(getInfo(wallet: wallet, closer: {money in return money > 100}))

print(getInfo(wallet: wallet, closer: {money in money == 100}))
print(getInfo(wallet: wallet, closer: {money in money > 100}))

print(getInfo(wallet: wallet, closer: {$0 == 100}))
print(getInfo(wallet: wallet, closer: {$0 > 100}))

print(getInfo(wallet: wallet)
{$0 == 100})
print(getInfo(wallet: wallet)
{$0 > 100})

let banknotes = [500, 1000]
print(getInfo(wallet: wallet)
{money in
    for n in banknotes {
        if n == money {
            return true
        }
    }
    return false
})

var sum: (Int, Int) -> Int = {
    return $0 + $1
}

print(sum(5, 5))
