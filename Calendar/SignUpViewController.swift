//
//  SignUpViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2023/01/18.
//

import Swift
import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }

        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }



    @IBAction func createUser() {
        let email = mailTextField.text ?? ""
        let password = passTextField.text ?? ""

        print(email)
        print(password)
        //新規会員登録
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // 会員登録完了

            if error == nil {
                // homeに遷移
            } else {
                // alert出す
            }

            print(authResult)
            print(error)
        }
    }
}

