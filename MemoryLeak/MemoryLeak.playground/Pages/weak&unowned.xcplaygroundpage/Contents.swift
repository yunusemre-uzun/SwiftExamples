//: [Previous](@previous)

import Foundation

class SomeClass {
    var someVar: Int = 0
    func callUnownedClosure() -> (() -> ()) {
        return { [unowned self] in
            self.someVar = 1
            print("unowned closure called")
            return
        }
    }
    
    func callWeakClosure() -> (() -> ()) {
        return { [weak self] in
            self?.someVar = 2
            print("weak closure called. is self nil: \(self == nil)")
            return
        }
    }
}

var object1: SomeClass? = SomeClass()

guard let weakClosure = object1?.callWeakClosure(),
      let unownedClosure = object1?.callUnownedClosure() else {
    exit(0)
}

weakClosure()
unownedClosure()

object1 = nil

weakClosure()
unownedClosure()
