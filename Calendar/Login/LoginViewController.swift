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
        guard let error = errorOrNil else { return }

        let message = "エラーが起きました"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func createNewUser(){}

    @IBAction func login() {
        let email = mailTextField.text ?? ""
        let password = passTextField.text ?? ""

        print(email)
        print(password)
        //ログイン
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            // ユーザー作成が成功したら、ユーザーのデータをデータベース(FireSrore)に書き込む
            if let error = error {
                print(error)
            } else {
                print("seikou")
                print(authResult?.user.uid)

                self.dismiss(animated: true)
            }
        }
    }
}
