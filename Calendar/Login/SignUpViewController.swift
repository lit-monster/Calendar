////
////  SignUpViewController.swift
////  Calendar
////
////  Created by 鈴木　葵葉 on 2023/01/18.
////
//
//import Swift
//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//class SignUpViewController: UIViewController {
//
//    let db = Firestore.firestore()
//
//    @IBOutlet var mailTextField: UITextField!
//    @IBOutlet var passTextField: UITextField!
//    @IBOutlet weak var signUpBlurView: UIVisualEffectView!{
//        didSet {
//            signUpBlurView.layer.cornerCurve = .continuous
//            signUpBlurView.layer.cornerRadius = 32
//            signUpBlurView.clipsToBounds = true
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.createUser()
//
//    }
//
//    private func showErrorIfNeeded(_ errorOrNil: Error?) {
//        // エラーがなければ何もしません
//        guard let error = errorOrNil else { return }
//
//        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//
//
//    @IBAction func createUser() {
//
//        let email = mailTextField.text ?? ""
//        let password = passTextField.text ?? ""
//
//        print(email)
//        print(password)
//
//
//
//
//        //新規会員登録
//        Auth.auth().createUser(withEmail: "1234567aoba@gmail.com", password: "1234567daff") { authResult, error in
//
//            print(authResult?.user)
//            // ユーザー作成が成功したら、ユーザーのデータをデータベース(FireSrore)に書き込む
//            if let error = error {
//                print(error)
//            } else {
//                // 書き込むコード。nameとemail
//                self.db.collection("users").document(authResult!.user.uid).setData([
//                    "name": "Aoba",
//                    "email": authResult!.user.email!
//                ]) { err in
//                    if let err = err {
//                        print("エラー: \(err)")
//                    } else {
//                        print("書き込み成功！")
//                        self.dismiss(animated: true)
//                    }
//                }
//            }
//        }
//    }
//
//}

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUser()
        createStudyRecord()
        fetchMyStudyRecord()
    }

    // ユーザー作成
    @IBAction func createUser() {
        // Authでユーザー作成
        Auth.auth().createUser(withEmail: "aoba1234578@gmail.com", password: "password12345") { authResult, error in

            // ユーザー作成が成功したら、ユーザーのデータをデータベース(FireSrore)に書き込む
            if let error = error {
                print(error)
            } else {
                // 書き込むコード。nameとemail
                self.db.collection("users").document(authResult!.user.uid).setData([
                    "name": "Aoba",
                    "email": "aoba@gmail.com"
                ]) { err in
                    if let err = err {
                        print("エラー: \(err)")
                    } else {
                        print("書き込み成功！")
                    }
                }

            }
        }
    }

    // 勉強データを書き込む
    @IBAction func createStudyRecord() {
        // 書き込むコード。uid(ユーザーのID)とtime(勉強時間)とconcentrate(集中度)
        self.db.collection("studyRecords").document().setData([
            "uid": "123456",
            "time": "10",
            "concentrate": "3"
        ]) { err in
            if let err = err {
                print("エラー: \(err)")
            } else {
                print("書き込み成功！")
            }
        }
    }

    // 自分の勉強データを取得
    func fetchMyStudyRecord() {
        self.db.collection("studyRecords").whereField("uid", isEqualTo: "123456")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }

    }



}

