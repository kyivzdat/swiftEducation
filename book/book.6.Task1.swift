var diary : [String:[String:UInt]] = ["Alex":["12.09.2019":10, "11.09.2019":9, "10.09.2019":11], "Cavin":["10.09.2019":9, "12.09.2019":10]]

var avrgClassMark : UInt = 0
var i : UInt = 0

for (name, data) in diary {
    var avrgStudentMark : UInt = 0;
    var numberOfMarks : UInt = 0;
    
    print("\(name) got in")
    for (date, mark) in data {
        print("\t\(date) a \(mark)")
        avrgStudentMark += mark
        numberOfMarks += 1;
        i += 1;
    }
    avrgClassMark += avrgStudentMark
    print("Average mark - \(avrgStudentMark / numberOfMarks)")
}
print("Average mark for class - \(avrgClassMark / i)")
