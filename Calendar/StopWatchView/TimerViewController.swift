//
//  Timer..swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import Foundation
import RealmSwift
import UIKit
import Gifu


class TimerViewController: UIViewController {
    
    var feedbackGenerator : UINotificationFeedbackGenerator? = nil
    
    var count: Int = 0
    var latestHeartRate: Double = 0.0
    var focusRate = 0
    
    var timer: Timer = Timer()
    var targetTimeInterval: CFTimeInterval = 0
    
    //時間の型で保存する、秒数で保存
    var startTime = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // インスタンスを生成し prepare() をコール
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalTimeLabel.text = String(count)
        heartRateLabel.text = String(latestHeartRate)
        if focusRate == 3 {
            starLabel.text = "★★★"
            recoLabal.text = "VERY HIGH"
        } else if focusRate == 2 {
            starLabel.text = "★★"
            recoLabal.text = "HIGH"
        } else if focusRate == 1 {
            starLabel.text = "★"
            recoLabal.text = "NORMAL"
        }
    }
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var heartRateLabel: UILabel!
    
    @IBOutlet weak var starLabel: UILabel!
    
    @IBOutlet weak var recoLabal: UILabel!
    
    @IBOutlet weak var imageView:GIFImageView!
    
    @IBAction func quality3(){
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
        self.count = 0
        self.feedbackGenerator?.notificationOccurred(.success)
    }
    
    @IBAction func quality2(){
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
        self.count = 0
        self.feedbackGenerator?.notificationOccurred(.success)
    }
    
    @IBAction func quality1(){
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
        self.count = 0
        self.feedbackGenerator?.notificationOccurred(.success)
        self.navigationController?.popViewController(animated: true)
    }
    
}
