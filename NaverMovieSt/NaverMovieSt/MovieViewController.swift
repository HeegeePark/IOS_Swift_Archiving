//
//  ViewController.swift
//  NaverMovieSt
//
//  Created by 박희지 on 2021/04/09.
//

import UIKit

class MovieViewController: UIViewController {

    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        
        return cell
    }
    
    
}

extension MovieViewController: UICollectionViewDelegate {
    
}

class ResultCell: UICollectionViewCell {
    
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

