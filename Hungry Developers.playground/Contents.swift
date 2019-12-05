import Foundation

class Spoon {
    private let spoonLock = NSLock()
    let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    func pickUp() {
        self.spoonLock.lock()
    }
    
    func putDown() {
        self.spoonLock.unlock()
    }
}

class Developer {
    var name: String
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func think() {
        print("Developer\(self.name) is thinking about eating.")
        
        let spoons = [leftSpoon, rightSpoon].sorted { $0.index < $1.index }
        
        for spoon in spoons {
            print("Developer \(self.name) picked up spoon \(spoon.index)")
            spoon.pickUp()
        }
    }
    
    func eat() {
        print("Developer \(self.name) is eating.")
        usleep(UInt32.random(in: 1...10))
        leftSpoon.putDown()
        rightSpoon.putDown()
    }
    
    func run() {
        while true {
            self.think()
            self.eat()
        }
    }
}

var spoon1 = Spoon(index: 1)
var spoon2 = Spoon(index: 2)
var spoon3 = Spoon(index: 3)
var spoon4 = Spoon(index: 4)
var spoon5 = Spoon(index: 5)


var Nar = Developer(name: "Nar", leftSpoon: spoon1, rightSpoon: spoon2)
var Kobe = Developer(name: "Kobe", leftSpoon: spoon2, rightSpoon: spoon3)
var Shaq = Developer(name: "Shaq", leftSpoon: spoon3, rightSpoon: spoon4)
var Lebron = Developer(name: "Lebron", leftSpoon: spoon4, rightSpoon: spoon5)
var AD = Developer(name: "AD", leftSpoon: spoon5, rightSpoon: spoon1)

var developers = [Nar, Kobe, Shaq, Lebron, AD]

DispatchQueue.concurrentPerform(iterations: 5) { developers[$0].run() }
