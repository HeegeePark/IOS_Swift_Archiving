//
//  HistoryViewController.swift
//  MyNetflix
//
//  Created by 박희지 on 2021/04/01.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Database.database().reference().child("searchHistory")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.observeSingleEvent(of: .value) { (snapshot) in
            print("---> snapshot: \(snapshot.value)")
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var searchTerm: UILabel!
}
