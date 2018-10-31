import UIKit
import Promises

var str = "Hello, playground"

let numbers = [10, 1, 2, 3]
Promise("0").reduce(numbers) { partialString, nextNumber in
    Promise(partialString + ", " + String(nextNumber))
    }.then { string in
        // Final result = 0, 1, 2, 3
        print("Final result = \(string)")
}
