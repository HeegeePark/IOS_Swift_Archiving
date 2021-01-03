import UIKit
import Foundation

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



// ---- Scope


var hours = 50
let payPerHour = 10000
var salary = 0

if hours > 40 {
    let extraHours = hours - 40
    salary += extraHours * payPerHour * 2
    hours -= extraHours
}

salary += hours * payPerHour

//    print(hours)


// ---- For Loop

let closedRange = 0...10
let halfClosedRange = 0..<10    // 0부터 9까지 (10 불포함)


var sum = 0
for i in closedRange {
    print("---> \(i)")
    sum += i
}

print("total: \(sum)")


var sinValue: CGFloat = 0
for i in closedRange {
    sinValue = sin(CGFloat.pi/4 * CGFloat(i))
}


let name = "Jason"
// for문 안에서 i가 쓰이지 않는다면, _로 대체 가능
for _ in closedRange {
//    print("--> name: \(name)")
}


// ---- Switch


let num = 5
switch num {
case _ where num % 2 == 0:      // where절 사용
    print("---> 짝수")
default:
    print("---> 홀수")
}

//let coordinate = (x: 10, y: 10)
//
//switch coordinates {        // 좌표 위치 찾기 Switch
//case (0, 0):
//    print("---> 원점이네요")
//case (_, 0):
//    print("---> x축이네요")
//case (0, _):
//    print("---> y축이네요")
//default:
//    print("---> 좌표 어딘가")
//}

let coordinate = (x: 10, y: 10)

switch coordinates {        // 좌표 위치 찾기 Switch_2
case (0, 0):
    print("---> 원점이네요")
case (let x, 0):
    print("---> x축이네요, x: \(x)")
case (0, let y):
    print("---> y축이네요, y:\(y)")
case (let x, let y) where x == y:
    print("---> x랑 y랑 같음 x,y = \(x),\(y)")
case (let x, let y):
    print("---> 좌표 어딘가 x,y = \(x),\(y)")
}

