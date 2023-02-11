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

    override func viewDidLoad() {
        super.viewDidLoad()
//        try! Auth.auth().signOut()

        let user = Auth.auth().currentUser
        print(user?.uid)
        // ログインしてたら
        if user != nil {

        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
}
