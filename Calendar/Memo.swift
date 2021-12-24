//
//  Memo.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import Foundation
import RealmSwift

//クラス名は大文字
class StudyRecord: Object {
    @objc dynamic var date: Date = .init()
    @objc dynamic var time: TimeInterval = 0
    @objc dynamic var quality: Int = 0
}
