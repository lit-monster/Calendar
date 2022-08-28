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
    
    var count: Int = 0
    
    var timer: Timer = Timer()
    var targetTimeInterval: CFTimeInterval = 0
    
    //時間の型で保存する、秒数で保存
    var startTime = TimeInterval()
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
