//
//  Memo.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var date: Date = Date()
//    @objc dynamic var studyTime: Int = 0
    @objc dynamic var studyTime: TimeInterval = 0
}
