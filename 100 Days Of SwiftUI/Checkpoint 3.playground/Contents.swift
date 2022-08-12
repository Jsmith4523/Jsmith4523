import UIKit
import Darwin

enum Issue: Error {
    case givennumbelow1
    case givennumberabove10K
    case noroot
}

func squareroot(_ integar: Int) throws {
    if integar >= 1 && integar <= 10000{
        for number in 1...100 {
            var finalcount: Int
            finalcount = number * number
            if finalcount == integar {
                print("The square root of \(integar) is \(number)")
                break
            }
            else if finalcount > 100 {
                throw Issue.noroot
            }
        }
    }
    else if integar < 1 {
        throw Issue.givennumbelow1
    }
    else if integar > 10000 {
        throw Issue.givennumberabove10K
    }
}

var given = 4
do {
    try squareroot(given)
} catch Issue.givennumberabove10K {
    print("This number is above 10,000. Go lower than that")
} catch Issue.givennumbelow1 {
    print("This number is below 1. Go higher than that")
} catch Issue.noroot {
    print("No square root found for number \(given)")
}
