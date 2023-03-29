//
//  ShareViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2023/02/11.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ShareViewController: UIViewController {

    @IBOutlet weak var accountView: UIVisualEffectView!{
        didSet {
            accountView.layer.cornerCurve = .continuous
            accountView.layer.cornerRadius = 32
            accountView.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        print(user?.uid)
        // ログインしてたら
        if user != nil {
            
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "tosignup", sender: nil)
            
        }
        catch let error as NSError {
            print(error)
        }

    }
    
    @IBAction func deleteUser(_ sender: Any) {
        let user = Auth.auth().currentUser

        user?.delete { error in
            if let error = error {
                // An error happened.
                print(error)
            } else {
                // Account deleted.
                self.performSegue(withIdentifier: "tosignup", sender: nil)
            }
        }
    }
}
