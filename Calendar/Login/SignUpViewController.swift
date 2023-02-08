//
//  SignUpViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2023/01/18.
//

import Swift
import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet weak var signUpBlurView: UIVisualEffectView!{
        didSet {
            signUpBlurView.layer.cornerCurve = .continuous
            signUpBlurView.layer.cornerRadius = 32
            signUpBlurView.clipsToBounds = true
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
    
    
    
    @IBAction func createUser() {
        
        let email = mailTextField.text ?? ""
        let password = passTextField.text ?? ""
        
        print(email)
        print(password)

        

        
        //新規会員登録
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

            // ユーザー作成が成功したら、ユーザーのデータをデータベース(FireSrore)に書き込む
            if let error = error {
                print(error)
            } else {
                // 書き込むコード。nameとemail
                self.db.collection("users").document(authResult!.user.uid).setData([
                    "name": "Aoba",
                    "email": authResult!.user.email!
                ]) { err in
                    if let err = err {
                        print("エラー: \(err)")
                    } else {
                        print("書き込み成功！")
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
}
