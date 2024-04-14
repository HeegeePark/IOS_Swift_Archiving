import UIKit

let result = [1, 2, 3].map { $0 + 1 }.map { "만 \($0)살" }
print(result)

let myResult: Result<Int, Error> = .success(2)
let result2 = myResult.map { $0 + 1 }
print(result2)

/*
 map이 다양한 타입에서 사용가능한 이유
 1. Generic 타입
 enum Optional<wrapped>
 associatedtype Element
 enum Result<Success, Failure> where Failure: Error
 associatedtype Output
 
 2. transform 함수를 인자로 받음
 t: A -> Optional<B>
 F<A> -> (map) -> F<B>
 */

// flatMap을 쓰는 이유

let ageString: String? = "10"

if let x = ageString.map(Int.init), let y = x {
    print(y)
}

if case let .some(.some(x)) = ageString.map(Int.init) {
    print(x)
}

if case let x?? = ageString.map(Int.init) {
    print(x)
}

let results = ageString.flatMap(Int.init)

// 화면 예시
// UIEvent -> IndexPath -> Model -> URL -> Data -> Model -> ViewModel -> View

struct MyModel: Decodable {
    let name: String
}

let myLabel = UILabel()

if let data = UserDefaults.standard.data(forKey: "my_data_key") {
    if let model = try? JSONDecoder().decode(MyModel.self, from: data) {
        let welcomeMessage = "Hello \(model.name)"
        myLabel.text = welcomeMessage
    }
}

// map과 flatMap으로 코드 개선

let welcomeMessage = UserDefaults.standard.data(forKey: "my_data_key")
    .flatMap { try? JSONDecoder().decode(MyModel.self, from: $0) }
    .map(\.name)
    .map { "Hello \($0)" }

myLabel.text = welcomeMessage

