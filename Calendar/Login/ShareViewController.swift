//
//  ShareViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2023/02/11.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ShareViewController: UIViewController {

    let db = Firestore.firestore()

    @IBOutlet weak var accountView: UIVisualEffectView!{
        didSet {
            accountView.layer.cornerCurve = .continuous
            accountView.layer.cornerRadius = 32
            accountView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    var outputValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        print(user?.uid)
        // ログインしてたら
        if user != nil {
            
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }

        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.nameLabel.text = data!["name"] as! String
                print(data!["name"])
            } else {
                print("Document does not exist")
            }
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
