//
//  TargetViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import Foundation
import UIKit
import RealmSwift
import HealthKit

class TargetViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func Picker(_ sender: Any) {
    }
    
    @IBAction func start() {
        print("picker のあたい")
        print(picker.countDownDuration)
    }
}
