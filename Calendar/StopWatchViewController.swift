//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import RealmSwift

class StopWatchViewController: UIViewController {
    var feedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet var label:UILabel!
    
    var count: Int = 0
    
    var timer: Timer = Timer()
    
    //時間の型で保存する、秒数で保存
    var startTime = TimeInterval()
    //UIDeviceクラスを呼ぶ
    let myDevice: UIDevice = UIDevice.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 近接センサーの有効化
        UIDevice.current.isProximityMonitoringEnabled = true
        
        // 近接センサーのON-Offが切り替わる通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(proximityMonitorStateDidChange),
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )
        // インスタンスを生成し prepare() をコール
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.isProximityMonitoringEnabled = false
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
            let save = UIAlertAction(title: "保存", style: .default) { _ in
                //保存ボタンを押された時の集中度合いの通知
                //アラート生成
                //UIAlertControllerのスタイルがalert
                let alert: UIAlertController = UIAlertController(title: "集中度合いを記録しよう", message:  "どのくらい集中した？", preferredStyle: .alert)
                // 確定ボタンの処理
                let quality3Action = UIAlertAction(title: "超集中(★★★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("超集中")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 3
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                }
                // 確定ボタンの処理
                let quality2Action = UIAlertAction(title: "集中(★★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("集中")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 2
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                }
                // 確定ボタンの処理
                let quality1Action = UIAlertAction(title: "普通(★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("普通")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 1
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                }
                
                
                //UIAlertControllerに集中ボタンをActionを追加
                alert.addAction(quality3Action)
                alert.addAction(quality2Action)
                alert.addAction(quality1Action)
                
                //実際にAlertを表示する
                self.present(alert, animated: true, completion: nil)
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
        let interval = Int(count)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        label.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
