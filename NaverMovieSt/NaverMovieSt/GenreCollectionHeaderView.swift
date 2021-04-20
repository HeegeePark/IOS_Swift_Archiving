//
//  GenreCollectionHeaderView.swift
//  NaverMovieSt
//
//  Created by 박희지 on 2021/04/16.
//



import UIKit
import Foundation

class GenreCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    var genreString: String = "드라마 판타지 서부 공포 로맨스 모험 스릴러 느와르 컬트 다큐멘터리 코미디 가족 미스터리 전쟁 애니메이션 범죄 뮤지컬 SF 액션 무협 에로 서스펜스 서사 블랙코미디 실험 영화카툰 영화음악 영화패러디포스터"
    var genres: [Genre] = []
    var buttonHandler: ((Genre) -> Void)?       // UI버튼에 장르넣어주는 핸들러
    
    func loadGenres() {
        // 장르 str -> struct에 저장
        let genreArr = genreString.split(separator: " ")
        
        genres = genreArr.map {
            Genre.id += 1
            return Genre(id: "\(Genre.id)", genre: String($0), isSelected: false)
        }
    }
    
    func updateUI() {
        
    }
}

class GenreCollectionHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}

class GenreCollectionHeaderView: UICollectionViewDelegate {
    
}

class GenreCollectionHeaderView: UICollectionViewDelegateFlowLayout {
    
}

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var genreButton: UIButton!
    
    // 스토리보드에서 ui콜렉션뷰가 로드될 때 호출됨
    override class func awakeFromNib() {
        super.awakeFromNib()
        // 버튼 디자인 관련 코드 (마진있는 둥글한 버튼?!)
        
    }
}

// Model genre
struct Genre: Codable {
    let id: String
    let genre: String
    var isSelected: Bool
    
    static var id: Int = 0
}
