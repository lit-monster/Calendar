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

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUser()
//        createStudyRecord()
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
//    @IBAction func createStudyRecord() {
//        // 書き込むコード。uid(ユーザーのID)とtime(勉強時間)とconcentrate(集中度)
//        self.db.collection("studyRecords").document().setData([
//            "uid": Auth.auth().currentUser!.uid,
//            "time": "10",
//            "concentrate": "3"
//        ]) { err in
//            if let err = err {
//                print("エラー: \(err)")
//            } else {
//                print("書き込み成功！")
//            }
//        }
//    }

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

