//
//  loginView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2023/01/18.
//

import Swift
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginBlurView: UIVisualEffectView!{
        didSet {
            loginBlurView.layer.cornerCurve = .continuous
            loginBlurView.layer.cornerRadius = 32
            loginBlurView.clipsToBounds = true
        }
    }
    
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


    @IBAction func createNewUser(){}

//    @IBAction func createUser() {
//        let email = mailTextField.text ?? ""
//        let password = passTextField.text ?? ""
//
//        print(email)
//        print(password)
//        //新規会員登録
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            // 会員登録完了
//
//            if error == nil {
//                // homeに遷移
//            } else {
//                // alert出す
//            }
//
//            print(authResult)
//            print(error)
//        }
//    }

    @IBAction func login() {
        // login
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//
//            guard let strongSelf = self else { return }
//            print(authResult?.user.uid)
//
//            if error == nil {
//                // homeに遷移
//            } else {
//                // alert出す
//            }
//
//            print(authResult)
//            print(error)
//        }

    }

}
