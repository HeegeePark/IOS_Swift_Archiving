//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Kingfisher       // imagepath -> image 해주는 외부 라이브러리
import AVFoundation
import Firebase

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    // 몇개 넘어오니?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // 어떻게 표현할거니?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell
        else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.item]
        // imagepath(string) -> image
        let url = URL(string: movie.thumbnailPath)!
        cell.movieThumbnail.kf.setImage(with: url)
        
        return cell
    }
    
    
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movie
        let movie = movies[indexPath.item]
        let url = URL(string: movie.previewURL)!
        let item = AVPlayerItem(url: url)
        
        // player vc
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen     // 풀스크린으로 vc 띄우기
        
        // player vc + movie
        vc.player.replaceCurrentItem(with: item)
        
        // presentiong player vc
        present(vc, animated: false, completion: nil)
    }
}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 8
        let itemSpacing: CGFloat = 10
        
        let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
        let height = width * 10/7
        return CGSize(width: width, height: height)
    }
}

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
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
        // - x 검색 API 가 필요
        // - x 결과를 받아올 모델 Movie, Response
        // - 결과물 받아와서, CollectionView로 표현
        
        SearchAPI.search(searchTerm) { movies in
            // x collectionview로 표현
            print("---> 넘어온 영화 개수: \(movies.count), \(movies.first?.title)")
            
            // ui 작업은 메인스레드에 넘겨줘야 함.
            DispatchQueue.main.async {
                self.movies = movies
                self.resultCollectionView.reloadData()
            }
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
