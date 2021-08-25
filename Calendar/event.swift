//
//  event.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/08/04.
//

import Foundation
import RealmSwift

class EventModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var memo = ""
    @objc dynamic var date = "" //yyyy.MM.dd
    @objc dynamic var start_time = "" //00:00
    @objc dynamic var end_time = "" //00:00
}
