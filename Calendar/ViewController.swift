//
//  ViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/12/28.
//
//
//import Foundation
//import UIKit
//
//class ViewController: UIViewController {
//
//    var animator: UIDynamicAnimator!
//    var gravity: UIGravityBehavior!
//    var collision: UICollisionBehavior!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Viewを作成して画面上に追加
//        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        redView.backgroundColor = .red
//        self.view.addSubview(redView)
//
//        // UIDynamicAnimatorを作成
//        animator = UIDynamicAnimator(referenceView: view)
//
//        // UIGravityBehaviorを作成して、Viewを重力で落下させるように設定
//        gravity = UIGravityBehavior(items: [redView])
//        animator.addBehavior(gravity)
//
//        // UICollisionBehaviorを作成して、画面の下端で反射させるように設定
//        collision = UICollisionBehavior(items: [redView])
//        collision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: view.bounds.height), to: CGPoint(x: view.bounds.width, y: view.bounds.height))
//        animator.addBehavior(collision)
//    }
//}

import UIKit
import CoreMotion
import Foundation

class ViewController: UIViewController {

    // UIViewを作成
    let View1 = UIView()
    let View2 = UIView()

    // UIAccelerometerを作成
    let motionManager = CMMotionManager()

    //    // Buttonを作成
    //    let showViewButton = UIButton()

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        // UIViewの設定
        View1.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        View1.backgroundColor = .red
        View1.center = view.center
        View1.layer.cornerRadius = 50
        view.addSubview(View1)
        View2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        View2.backgroundColor = .systemPink
        View2.center = view.center
        View2.layer.cornerRadius = 50
        view.addSubview(View2)

        // UIAccelerometerの設定
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let data = data, error == nil else { return }
            let x = data.acceleration.x
            let y = data.acceleration.y
            self?.moveIcon(x: x, y: y)
        }

        //        // Buttonの設定
        //        showViewButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        //        showViewButton.setTitle("Show View", for: .normal)
        //        showViewButton.setTitleColor(.black, for: .normal)
        //        showViewButton.center = view.center
        //        view.addSubview(showViewButton)

        //        // Buttonがタップされたときに実行する処理を設定
        //        showViewButton.addTarget(self, action: #selector(showView), for: .touchUpInside)

        // UIDynamicAnimatorを作成
        animator = UIDynamicAnimator(referenceView: view)

        // UIGravityBehaviorを作成して、Viewを重力で落下させるように設定
        gravity = UIGravityBehavior(items: [View1])
        animator.addBehavior(gravity)

        // UICollisionBehaviorを作成して、画面の下端で反射させるように設定
        let collision = UICollisionBehavior(items: [View1, View2])
        collision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: view.bounds.height), to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    // アイコンを移動させる関数
    func moveIcon(x: Double, y: Double) {
        let screenSize = view.frame.size
        let iconSize = View1.frame.size
        let posX = View1.center.x + CGFloat(x * 10)  // 加速度を5倍にする
        let posY = View1.center.y - CGFloat(y * 10)  // 加速度を5倍にする

        if posX > screenSize.width - iconSize.width / 2 {
            View1.center.x = screenSize.width - iconSize.width / 2
        } else if posX < iconSize.width / 2 {
            View1.center.x = iconSize.width / 2
        } else {
            View1.center.x = posX
        }
        if posY > screenSize.height - iconSize.height / 2 {
            View1.center.y = screenSize.height - iconSize.height / 2
        } else if posY < iconSize.height / 2 {
            View1.center.y = iconSize.height / 2
        } else {
            View1.center.y = posY
        }


    }
    //    // 新たにViewを表示する関数
    //    @objc func showView() {
    //        let newView = UIView()
    //        newView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    //        newView.backgroundColor = .green
    //        newView.center = view.center
    //        view.addSubview(newView)
    //    }

}

