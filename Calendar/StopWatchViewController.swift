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
    
    var count: Float = 0.0
    
    var  timer:Timer = Timer()
    
    //時間の型で保存する、小数まで保存
    var startTime = TimeInterval()
    
    //UIDeviceクラスを呼ぶ
    let myDevice: UIDevice = UIDevice.current
    
    
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
        }
    }
    
    @objc func up() {
        //countを0.01足す
        count = count + 0.01
        //            ラベル小数点以下2行まで表示
        label.text = String(format: "%.2f", count)
    }
    
    @IBAction func save(){
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        //ここから追加
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        //ここまで追加
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
}
