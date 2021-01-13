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
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    // 뷰가 메모리에 올라온 시점에 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    // 뷰가 실행된 이후 호출
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
        
    }
    
    private func prepareAnimation() {
        nameLabelCenterX.constant = view.bounds.width
        bountyLabelCenterX.constant = view.bounds.width
    }
    
    private func showAnimation() {
        // constant가 0 = 가운데에 있음
        // 레이아웃의 값 변경됨.
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
        // withDuration: 얼마동안 일어날 것인가?
        // delay: 애니메이션이 일어나기 전 얼마나 딜레이 할지
        // options: 애니메이션 어떤 효과?
        // animations: 애니메이션 실행 부분
        // completion: 애니메이션이 끝난 후 할 부분
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.1,
//                       options: .curveEaseIn,
//                       animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
        
        // 스프링같이 통통뛰는 효과 줄 수 있음
        // layoutIfNeeded(): 레이아웃을 다시 조정해야하면 하렴
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.transition(with: imgView,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: nil,
                          completion: nil
        )
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
