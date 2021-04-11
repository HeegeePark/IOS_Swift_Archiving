//
//  ViewController.swift
//  NaverMovieSt
//
//  Created by 박희지 on 2021/04/09.
//

// 해야할 것
// - 스토리보드에 스크롤뷰 깔기
// - 장르버튼 w,h 픽스 및 테두리 둥글게
// - 한 VC안에 두 개의 CollectionView 처리하는 법 찾기

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movies.count
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return UICollectionViewCell() }
//        let movie = movies[indexPath.item]
        
        return cell
    }
}

// cell을 클릭했을 때 이벤트 작성
extension MovieViewController: UICollectionViewDelegate {
    
    
}

// collectionView cell 크기 조정
extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 8
        let itemSpacing: CGFloat = 10
        
        let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
        let height = width * 10/7
        return CGSize(width: width, height: height)
    }
}

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var genreButton: UIButton!
}

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
}

// Model movie
struct Movie: Codable {
    var title: String
    var thumbnailPath: String
    
    enum CoidngKeys: String, CodingKey {
        case title
        case thumbnailPath = "image"
    }
}

