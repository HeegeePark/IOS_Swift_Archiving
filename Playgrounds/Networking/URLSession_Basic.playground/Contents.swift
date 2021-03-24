import UIKit

// URLSession

// 1. URLSessionConfiguration
// 2. URLSession
// 3. URLSessionTask를 이용해서 서버와 네트워킹

// URLSessionTask

// - dataTask
// - uploadTask
// - downloadTask


let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL Components
var urlComponents = URLComponents(string: "https://github.com/HeegeePark?")!
let tabQuery = URLQueryItem(name: "tab", value: "overview")
let fromQuery = URLQueryItem(name: "from", value: "2020-12-01")
let toQuery = URLQueryItem(name: "to", value: "2020-12-31")
urlComponents.queryItems?.append(tabQuery)
urlComponents.queryItems?.append(fromQuery)
urlComponents.queryItems?.append(toQuery)
let requestURL = urlComponents.url!

let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200..<300
    
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    
    guard let resultData = data else { return }
    let resultString = String(data: resultData, encoding: .utf8)
    
    print("---> result: \(resultString)")
}

// dataTask 실행
dataTask.resume()
