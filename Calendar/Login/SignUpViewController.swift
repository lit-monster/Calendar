////
////  SignUpViewController.swift
////  Calendar
////
////  Created by 鈴木　葵葉 on 2023/01/18.
////
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var signUpView: UIVisualEffectView!{
        didSet {
            signUpView.layer.cornerCurve = .continuous
            signUpView.layer.cornerRadius = 32
            signUpView.clipsToBounds = true
        }
    }

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    // segueが動作することをViewControllerに通知するメソッド
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toname" {
//            let next = segue.destination as! ShareViewController
//            next.outputValue = self.nameTextField.text
//        }
//    }

//    @IBAction func tapTransitionButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "toname", sender: nil)
//    }

    // ユーザー作成
    @IBAction func createUser() {

        let email = mailTextField.text ?? ""
        let password = passTextField.text ?? ""
        let name = nameTextField.text ?? ""

        print(email)
        print(password)
        
        // Authでユーザー作成
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

            // ユーザー作成が成功したら、ユーザーのデータをデータベース(FireSrore)に書き込む
            if let error = error {

                let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "閉じる", style: .default))
                self.present(alert, animated: true)
                print(error)
            } else {
                // 書き込むコード。nameとemail
                self.db.collection("users").document(authResult!.user.uid).setData([
                    "name": name,
                    "email": email
                ]) { err in
                    if let err = err {
                        print("エラー: \(err)")
                    } else {
                        self.dismiss(animated: true)
                        print("書き込み成功！")
                    }
                }
            }
        }
    }

    // 自分の勉強データを取得
    //    func fetchMyStudyRecord() {
    //        self.db.collection("studyRecords").whereField("uid", isEqualTo: "123456")
    //            .getDocuments() { (querySnapshot, err) in
    //                if let err = err {
    //                    print("Error getting documents: \(err)")
    //                } else {
    //                    for document in querySnapshot!.documents {
    //                        print("\(document.documentID) => \(document.data())")
    //                    }
    //                }
    //        }
    //
    //    }



}

