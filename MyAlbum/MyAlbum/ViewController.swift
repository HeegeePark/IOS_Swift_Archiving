//
//  ViewController.swift
//  MyAlbum
//
//  Created by 박희지 on 2020/12/22.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    
    // 레이블을 아울렛 연결
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let message = "가격은 ₩\(currentValue) 입니다."
        
        // UIAlertController으로 alert 생성
        let alert = UIAlertController(title: "Hello", message: message, preferredStyle: .alert)
        
        // UIAlertAction으로 얼럿에 대한 액션 정의
        // 따로 다른 조치 취하지 않으니 핸들러는 nil
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        // 정의한 액션을 만들었던 얼럿에 추가
        alert.addAction(action)
        
        // present로 얼럿 띄우기
        present(alert, animated: true, completion: nil)
        
        refresh()
    }
    
    // 가격 초기화
    func refresh() {
        let randomPrice = arc4random_uniform(10000) + 1
        currentValue = Int(randomPrice)
        priceLabel.text = "₩ \(currentValue)"
    }
}

