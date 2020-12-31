import UIKit

var str = "Hello, playground"


// --- Tuple

let coordinates = (4,6)

let x = coordinates.0
let y = coordinates.1

// 가독성 up 버전
let coordinatesNamed = (x: 2, y: 3)

let x2 = coordinatesNamed.x
let y2 = coordinatesNamed.y

let (x3, y3) = coordinatesNamed
x3
y3


// --- Boolean

let yes = true
let no = false

let isFourGreaterThanFive = 4 > 5

//if isFourGreaterThanFive {
//    print("---> 참")
//} else {
//    print("---> 거짓")
//}

let name1 = "Jin"
let name2 = "Jason"

let isTwoNameSame = name1 == name2

if isTwoNameSame {
    print("---> 이름이 같다")
} else {
    print("---> 이름이 다르다")
}
 

let isJason = name2 == "Jason"
let isMale = true

let jasonAndMale = isJason && isMale
let jasonOrMale = isJason || isMale

let greetingMessage: String = isJason ? "Hello Jason" : "Hello Somebody"
print("Msg: \(greetingMessage)")