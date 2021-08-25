//
//  Memo.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
