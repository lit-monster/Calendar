//
//  TargetViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import Foundation
import UIKit
import RealmSwift

class TargetViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func start() {
        print("picker のあたい")
        print(picker.countDownDuration)
    }
}
