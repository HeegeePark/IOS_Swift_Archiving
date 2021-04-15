//
//  ViewController.swift
//  NaverMovieSt
//
//  Created by 박희지 on 2021/04/09.
//

// 해야할 것
// - 장르버튼 w,h 픽스 및 테두리 둥글게
// - 한 VC 안에 두 개의 CollectionView 처리하는 법 찾기 -> Collectionview Header에 새로운 Collectionview 추가함!
// - 헤더뷰 ui관련 GenreCollectionHeaderView로 옮기기

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    var movies: [Movie] = []
    var genres: [Genre] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension MovieViewController: UICollectionViewDataSource {
    // 몇개 표시할 지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movies.count
        return 9
    }
    
    // 셀 어떻게 표시할 건지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return UICollectionViewCell() }
//        let movie = movies[indexPath.item]
        
        return cell
    }
    
    // 헤더뷰(장르 콜렉션뷰) 표시
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            // 헤더뷰 (장르 버튼 콜렉션뷰) 구성
//            guard let genres = self.genres else { return UICollectionReusableView() }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCell else {
                        return UICollectionViewCell()
                    }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GenreCollectionHeaderView", for: indexPath) as? GenreCollectionHeaderView else { return UICollectionReusableView() }
            
            return header
        default:
            return UICollectionReusableView()
        }
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

// Model genre
struct Genre {
    let id: Int
    let genre: String
    var isSelected: Bool
}

