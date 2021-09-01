//
//  ViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/06/30.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate {
    
    let realm = try! Realm()
    
//    @IBOutlet var titleTextField: UITextField!
//    @IBOutlet var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        titleTextField.delegate = self
//        contentTextField.delegate = self
        
        let memo: Memo? = read()
        
        //メモという定数に取得したデータを代入
//        if let memo = memo {
//            titleTextField.text =
//            contentTextField.text =
//        }
        // Do any additional setup after loading the view.
    }

    func read() -> Memo? {
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save(){
        //タイトルとカウントという定数をTextFieldに入力された文字列を取得
//        let title:String = titleTextField.text!
//        let content:String = contentTextField.text!
        
        func textFiledShouldReturn(_ textField: UITextField) -> Bool{
            textField.resignFirstResponder()
        }
        
        let memo: Memo? = read()
        
        if let memo = memo{
            //メモの更新をする
            try! realm.write{
//                memo.title = title
//                memo.content = content
            }
        } else {
            //メモの新規作成
            //newMemoを実体化(インスタンスオブジェクト)
            let newMemo = Memo()
//            newMemo.title = title
//            newMemo.content = content
            
            try! realm.write{
                realm.add(newMemo)
            }
        }
        let alert:UIAlertController = UIAlertController(title:"成功",message:"保存しました",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style: .default,handler: nil)
        )
        present(alert,animated: true, completion: nil)
    }
}
