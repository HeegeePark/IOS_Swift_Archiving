//
//  BountyViewController.swift
//  BountyList
//
//  Created by 박희지 on 2021/01/04.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MVVM
    
    // Model
    // BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트하기
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만들고, 뷰 레이어에서 필요한 메서드 만들기
    // > Model 가지고 있기, BountyInfo 등
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    // segue 수행되기 직전 준비하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // -> DetailViewController 데이터 줄 거
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                
                let bountyInfo = bountyInfoList[index]
                vc?.bountyInfo = bountyInfo
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableViewDataSource
    // cell 몇 개를 띄울건지, 어떻게 띄울건지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // guard ... else : ... 이 nil이면 else 구문 실행
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = bountyInfoList[indexPath.row]
        cell.imageView?.image = bountyInfo.image
        cell.nameLabel.text = bountyInfo.name
        cell.bountyLabel.text = "\(bountyInfo.bounty)"
        return cell
    }
    
    // UITableViewDelegate
    // 클릭이 되면 어떻게 응답할 것인지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // showDetail segue 실행
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

// custom cell
class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
