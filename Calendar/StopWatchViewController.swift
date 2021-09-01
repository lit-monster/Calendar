//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import RealmSwift

class StopWatch: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var label:UILabel!
        
        var count: Float = 0.0
        
        var  timer:Timer = Timer()
    
    //時間の型で保存する、小数まで保存
    var startTime = TimeInterval()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func up() {
            //countを0.01足す
        count = count + 0.01
//            ラベル小数点以下2行まで表示
            label.text = String(format: "%.2f", count)
        }

        @IBAction func start(){
            if !timer.isValid {
                //タイマーが動作してなかったら動かす
                timer = Timer.scheduledTimer(timeInterval: 0.01,
                                             target: self,
                                             selector: #selector(self.up),
                                             userInfo: nil,
                                             repeats:true
                )
            }
        }
        
        @IBAction func stop(){
            if timer.isValid{
                //タイマーが動作したら停止する
                timer.invalidate()
                
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

}
