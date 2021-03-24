import UIKit

// URL

let urlString = "https://github.com/HeegeePark?tab=overview&from=2020-12-01&to=2020-12-31"
let url = URL(string: urlString)

url?.absoluteString     // url 주소
url?.scheme     // 네트워킹 방법 (프로토콜)
url?.host       // 본 주소
url?.path       // 서브 주소
url?.query      // 쿼리
url?.baseURL

// baseURL이 나오게 하는 코드

let baseURL = URL(string: "https://github.com")
let relativeURL = URL(string: "HeegeePark?tab=overview&from=2020-12-01&to=2020-12-31", relativeTo: baseURL)

relativeURL?.absoluteString     // url 주소
relativeURL?.scheme     // 네트워킹 방법 (프로토콜)
relativeURL?.host       // 본 주소
relativeURL?.path       // 서브 주소
relativeURL?.query      // 쿼리
relativeURL?.baseURL


// URLComponents
// 서버가 이해할 수 있는 언어로 인코딩하는 데에 도와줌 (value에 한글을 써도 이해할 수 있는 문자로 변경됨)

var urlComponents = URLComponents(string: "https://github.com/HeegeePark?")
let tabQuery = URLQueryItem(name: "tab", value: "overview")
let fromQuery = URLQueryItem(name: "from", value: "2020-12-01")
let toQuery = URLQueryItem(name: "to", value: "2020-12-31")

urlComponents?.queryItems?.append(tabQuery)
urlComponents?.queryItems?.append(fromQuery)
urlComponents?.queryItems?.append(toQuery)

urlComponents?.url
urlComponents?.string
urlComponents?.queryItems?.last?.value
