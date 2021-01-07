//
//  BountyViewController.swift
//  BountyList
//
//  Created by 박희지 on 2021/01/04.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDataSource
    // cell 몇 개를 띄울건지, 어떻게 띄울건지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    // UITableViewDelegate
    // 클릭이 되면 어떻게 응답할 것인지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-->\(indexPath)")
    }
}
