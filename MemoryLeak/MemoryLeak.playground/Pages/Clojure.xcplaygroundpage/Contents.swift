// Other types of memory leak are caused by clojures

import UIKit

class TestClass {
    var aClosure: (() -> ())?
    var a: Int = 0
    func leakedFunction() {
        aClosure = {
            self.setA(newA: 1)
        }
        aClosure?()
    }
    
    func notLeakedFunction() {
        aClosure = { [weak self] in
            self?.setA(newA: 2)
        }
        aClosure?()
    }
    
    func setA(newA: Int) {
        a = newA
    }
    
    deinit {
        print("deinit called for the class")
    }
}

// Given a class with tho methods
var aClass: TestClass? = TestClass()
print("Class is created")

// When a leaked function called
aClass!.leakedFunction()
print("Leaked function is called")

// Then class reference is set to be nil
aClass = nil
print("Class reference is set to be nil. it should removed from the memory unless there is a memory leak")

// We do not expect a deinit call because the closure captures self which leads a memory leak

// Given a class with tho methods
aClass = TestClass()
print("Class is created")

// When a not leaked function called
aClass!.notLeakedFunction()
print("Non leaked function is called")

// Then class reference is set to be nil
aClass = nil
print("Class reference is set to be nil. it should removed from the memory unless there is a memory leak")

// We do expect a deinit call because the closure captures self as weak
