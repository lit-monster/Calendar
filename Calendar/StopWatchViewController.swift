//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import RealmSwift

class StopWatchViewController: UIViewController {
    
    
    // プロパティを用意
    var feedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // インスタンスを生成し prepare() をコール
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 一応 nil にしておく
        self.feedbackGenerator = nil
    }
    
    
    //    let realm = try! Realm()
    
    @IBOutlet var label:UILabel!
    
    var count: Int = 0
    
    var  timer:Timer = Timer()
    
    //時間の型で保存する、小数まで保存
    var startTime = TimeInterval()
    
    //UIDeviceクラスを呼ぶ
    let myDevice: UIDevice = UIDevice.current
    
    
    //集中度合いの記録
    let quality: [Int] = [3,2,1]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // 近接センサーの有効化
        UIDevice.current.isProximityMonitoringEnabled = true
        
        // 近接センサーのON-Offが切り替わる通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(proximityMonitorStateDidChange),
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    // 近接センサーのON-Offが切り替わると実行される
    @objc func proximityMonitorStateDidChange() {
        let proximityState = UIDevice.current.proximityState
        print(proximityState)
        
        if proximityState {
            if !timer.isValid {
                //タイマーが動作してなかったら動かす
                timer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(self.up),
                                             userInfo: nil,
                                             repeats:true
                )
            }
        } else {
            timer.invalidate()
            self.feedbackGenerator?.notificationOccurred(.success)
            let alert = UIAlertController(title: "記録を保存する", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
                
                
            }
            //ここから追加
            let save = UIAlertAction(title: "保存", style: .default) { [weak self]action in
                self?.dismiss(animated: true, completion: nil)
                
                //保存ボタンを押された時の集中度合いの通知
                //アラート生成
                //UIAlertControllerのスタイルがalert
                let alert: UIAlertController = UIAlertController(title: "集中度合いを記録しよう", message:  "どのくらい集中した？", preferredStyle:  UIAlertController.Style.alert)
                // 確定ボタンの処理
                let quality3Action: UIAlertAction = UIAlertAction(title: "超集中(★★★)", style: UIAlertAction.Style.default, handler:{
                    // 確定ボタンが押された時の処理をクロージャ実装する
                    (action: UIAlertAction!) -> Void in
                    //実際の処理
                    print("超集中")
                    print(self?.quality[0])
                })
                // 確定ボタンの処理
                let quality2Action: UIAlertAction = UIAlertAction(title: "集中(★★)", style: UIAlertAction.Style.default, handler:{
                    // 確定ボタンが押された時の処理をクロージャ実装する
                    (action: UIAlertAction!) -> Void in
                    //実際の処理
                    print("集中")
                    print(self?.quality[1])
                })
                // 確定ボタンの処理
                let quality1Action: UIAlertAction = UIAlertAction(title: "普通(★)", style: UIAlertAction.Style.default, handler:{
                    // 確定ボタンが押された時の処理をクロージャ実装する
                    (action: UIAlertAction!) -> Void in
                    //実際の処理
                    print("普通")
                    print(self?.quality[2])
                })

                
                //UIAlertControllerに集中ボタンをActionを追加
                alert.addAction(quality3Action)
                alert.addAction(quality2Action)
                alert.addAction(quality1Action)
            
                //実際にAlertを表示する
                self?.present(alert, animated: true, completion: nil)
                
                //保存する記録
                let studyRecord = StudyRecord()
                studyRecord.date = Date()
                studyRecord.quality = 2
                studyRecord.time = TimeInterval(self?.count ?? 0)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(studyRecord)
                }
            }
            
            let pause = UIAlertAction(title: "一時停止", style: .default) { (acrion) in
                self.dismiss(animated: true, completion: nil)
                
                
                
            }
            
            alert.addAction(save)
            alert.addAction(pause)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func up() {
        //countを0.01足す
        count = count + 1
        //ラベル表示
        label.text = String(count)
    }
}
