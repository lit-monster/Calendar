//
//  UIDatePickerViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/12/04.
//

import UIKit

class UIDatePickerViewController: UIViewController {
    
    class ViewController: UIViewController {
        @IBOutlet weak var textField: UITextField!
        
        var datePicker: UIDatePicker = UIDatePicker()
        
        // 決定ボタン押下
            @objc func done() {
                textField.endEditing(true)
                
                // 日付のフォーマットUIDatePicker.Mode
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                textField.text = "\(formatter.string(from: Date()))"
            }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
                datePicker.timeZone = NSTimeZone.local
                datePicker.locale = Locale.current
                textField.inputView = datePicker
                
                // 決定バーの生成
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
                let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
                toolbar.setItems([spacelItem, doneItem], animated: true)
                
                // インプットビュー設定
                textField.inputView = datePicker
                textField.inputAccessoryView = toolbar
        
        
        
        // Do any additional setup after loading the view.
    }
    
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

