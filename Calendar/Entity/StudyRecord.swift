//
//  StudyRecord.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import Foundation
import RealmSwift

class StudyRecord: Object {
    @objc dynamic var date: Date = .init()
    @objc dynamic var time: TimeInterval = 0
    @objc dynamic var quality: Int = 0
    
    override init() {
        super.init()
    }
    
    init(date: Date, time: TimeInterval, quality: Int) {
        super.init()
        self.date = date
        self.time = time
        self.quality = quality
    }
}
