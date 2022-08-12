import UIKit

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs =  legs
    }
}

class Dog: Animal {
    func speak() {
        print("Woof")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("Meow")
    }
}

class Corgi: Dog {
    
    override init(legs: Int) {
        super.init(legs: legs)
    }
    
    override func speak() {
        print("I'm a talking Corgi")
    }
}

class Poodle: Dog {
    
    override init(legs: Int) {
        super.init(legs: legs)
    }
    
    override func speak() {
        print("Woof, but that other dog talks...")
    }
}

class Persian: Cat {
    override init(isTame: Bool) {
        super.init(isTame: isTame)
    }
    
    override func speak() {
        print("Meow. At least I think I'm supposed to say that")
    }
}

class Lion: Cat {
    override init(isTame: Bool) {
        super.init(isTame: isTame)
    }
    override func speak() {
        print("Roar!!")
    }
}



let firstDog = Corgi(legs: 4)
firstDog.speak()

let secondDog = Poodle(legs: 3)
secondDog.speak()

let firstCat = Persian(isTame: false)
firstCat.legs = 4
firstCat.speak()

let secondCat = Lion(isTame: true)
secondCat.legs = 4
secondCat.speak()







