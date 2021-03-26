//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    // 서치바 검색 클릭 했을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 키보드가 올라와 있을 때, 내려가게 처리
        dismissKeyboard()
        // 검색어가 있는지 확인
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
//        print("---> 검색어: \(searchBar.text)")
        
        // 네트워킹을 통한 검색
        // - 목표: 서치텀을 가지고 네트워킹을 통해서 영화 검색
        // - 검색 API 가 필요
        // - 결과를 받아올 모델 Movie, Response
        // - 결과물 받아와서, CollectionView로 표현
        
        SearchAPI.search(searchTerm) { movies in
            // collectionview로 표현
            print("---> 넘어온 영화 개수: \(movies.count), \(movies.first?.title)")
        }
    }
}

class SearchAPI {
    // 타입 메서드로
    // @escaping: 컴플리션 안에 있는 코드 블럭이 메서드 바깥에서도 실행 가능함을 나타냄
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void) {
        let session = URLSession(configuration: .default)
        
        // URL Components
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                completion([])      // 객체가 없다고 넘겨주기
                return
            }
            
            guard let resultData = data else {
                completion([])      // 객체가 없다고 넘겨주기
                return
            }
//            let resultString = String(data: resultData, encoding: .utf8)
            
            // data -> [Movie]
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            print(" do 데이터: \(data)")
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            return movies
        } catch let error {
            print("---> parsing error: \(error.localizedDescription)")
            return []
        }
    }
}

struct  Response: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}
struct  Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
