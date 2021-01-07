//
//  DetailViewController.swift
//  BountyList
//
//  Created by 박희지 on 2021/01/07.
//

import UIKit

class DetailViewController: UIViewController {

    // MVVM
    
    // Model
    // BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - imgView, nameLabel, bountyLabel
    // > view들은 viewModel를 통해 구성하기
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트하기
    
    // ViewModel
    // - DetailViewModel
    // > 뷰 레이어에서 필요한 메서드 만들기
    // > Model 가지고 있기, BountyInfo 등
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
        
    }
   
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
    
}
