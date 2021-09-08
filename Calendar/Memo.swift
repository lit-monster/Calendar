//
//  Memo.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import Foundation
import RealmSwift

//クラス名は大文字
class Memo: Object {
    //変数名は小文字
    @objc dynamic var date: Date = Date()
    @objc dynamic var studyTime: TimeInterval = 0
}
