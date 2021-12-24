//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import RealmSwift

class StopWatchViewController: UIViewController {
    // HapticFeedback用のプロパティ(変数)を用意
    var feedbackGenerator : UINotificationFeedbackGenerator? = nil

    @IBOutlet var label: UILabel!
    
    var count: Float = 0.0
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
                timer = Timer.scheduledTimer(timeInterval: 0.01,
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
                let studyRecord = StudyRecord()
                studyRecord.date = Date()
                studyRecord.quality = 2
                studyRecord.time = 1000
                let realm = try! Realm()
                try! realm.write {
                    realm.add(studyRecord)
                }

                self.dismiss(animated: true, completion: nil)
            }
            
            let pause = UIAlertAction(title: "一時停止", style: .default) { _ in
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
        count = count + 0.01
        //ラベル小数点以下2行まで表示
        label.text = String(format: "%.2f", count)
    }
}
