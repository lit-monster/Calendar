//
//  ViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/12/28.
//
//

import UIKit
import CoreMotion
import Foundation

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    // UIViewを作成
    let View1 = UIView()
    let View2 = UIView()
    // UIAccelerometerを作成
    let motionManager = CMMotionManager()

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
            self?.moveIcon1(x: x, y: y)
        }
        // UIDynamicAnimatorを作成
        animator = UIDynamicAnimator(referenceView: view)

        // UICollisionBehaviorを作成して、画面の下端で反射させるように設定
        let collision = UICollisionBehavior(items: [View1, View2])
        collision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: view.bounds.height), to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        // 画面のフレームを境界線とする
        collision.translatesReferenceBoundsIntoBoundary = true
        // Collision delegateを設定
        collision.collisionDelegate = self
        // Dynamic animatorにcollision behaviorを追加
        animator.addBehavior(collision)
        // Gravity behaviorを作成
        let gravity = UIGravityBehavior(items: [View1,View2])
        // Dynamic animatorにgravity behaviorを追加
        animator.addBehavior(gravity)
    }

    // アイコンを移動させる関数
    func moveIcon(x: Double, y: Double) {
        let screenSize = view.frame.size
        let iconSize = View1.frame.size
        let posX = View1.center.x + CGFloat(x * 15)  // 加速度をx倍にする
        let posY = View1.center.y - CGFloat(y * 15)  // 加速度をx倍にする

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
    func moveIcon1(x: Double, y: Double) {
        let screenSize = view.frame.size
        let iconSize = View2.frame.size
        let posX = View2.center.x + CGFloat(x * 15)  // 加速度をx倍にする
        let posY = View2.center.y - CGFloat(y * 15)  // 加速度をx倍にする

        if posX > screenSize.width - iconSize.width / 2 {
            View2.center.x = screenSize.width - iconSize.width / 2
        } else if posX < iconSize.width / 2 {
            View2.center.x = iconSize.width / 2
        } else {
            View2.center.x = posX
        }
        if posY > screenSize.height - iconSize.height / 2 {
            View2.center.y = screenSize.height - iconSize.height / 2
        } else if posY < iconSize.height / 2 {
            View2.center.y = iconSize.height / 2
        } else {
            View2.center.y = posY
        }
    }
}

