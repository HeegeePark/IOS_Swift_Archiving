//
//  ViewController.swift
//  Firebase101
//
//  Created by 박희지 on 2021/03/30.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    // Firebase Realtime Database
    let db = Database.database().reference()

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLabel()
    }
    
    func updateLabel() {
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("--> \(snapshot)")
            
            let value = snapshot.value as? String ?? ""
            
            DispatchQueue.main.async {
                self.dataLabel.text = value
            }
        }
    }
}

