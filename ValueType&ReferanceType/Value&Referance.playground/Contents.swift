import UIKit

class PersonClass {
    var name: String
    var age: Int
    var isMale: Bool
    
    init(name: String, age: Int, isMale: Bool) {
        self.name = name
        self.age = age
        self.isMale = isMale
    }
}

struct PersonStruct {
    var name: String
    var age: Int
    var isMale: Bool
}

let aPersonClass = PersonClass(name: "Ahmet", age: 30, isMale: true)
var aPersonStruct = PersonStruct(name: "Ahmet", age: 30, isMale: true)

func changeName(_ aPerson: PersonClass, to: String) {
    aPerson.name = to
    print("Class object address in function: \(Unmanaged.passUnretained(aPerson).toOpaque())")
}


func changeName( _ aPerson: inout PersonStruct, to: String) {
    aPerson.name = to
    withUnsafeMutablePointer(to: &aPerson, { print("iout struct object address in function: \($0)")})
}

print("Class object name: \(aPersonClass.name)")
print("Class object address: \(Unmanaged.passUnretained(aPersonClass).toOpaque())")
changeName(aPersonClass, to: "Mehmet")
print("Class object name: \(aPersonClass.name)")

var copyStruct = aPersonStruct // Struct will be copied. So no change would be expected in aPersonStruct
withUnsafeMutablePointer(to: &aPersonStruct, { print("Struct object address: \($0)")})
withUnsafeMutablePointer(to: &copyStruct, { print("Copy Struct object address: \($0)")})

copyStruct.name = "Recep"
print("Struct object name: \(aPersonStruct.name)")
print("Copy struct object name: \(copyStruct.name)")

print("Struct object name: \(aPersonStruct.name)")
withUnsafeMutablePointer(to: &aPersonStruct, { print("Struct object address: \($0)")})
changeName(&aPersonStruct, to: "Mehmet")
print("Struct object name after inout function call: \(aPersonClass.name)")




