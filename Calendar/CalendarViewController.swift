//
//  CalendarViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import UIKit
import RealmSwift

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    class EventModel: Object {
        @objc dynamic var title = ""
        @objc dynamic var memo = ""
        @objc dynamic var date = "" //yyyy.MM.dd
        @objc dynamic var start_time = "" //00:00
        @objc dynamic var end_time = "" //00:00
    }

}
