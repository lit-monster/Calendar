//
//  ViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/12/28.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Viewを作成して画面上に追加
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        redView.backgroundColor = .red
        self.view.addSubview(redView)

        // UIDynamicAnimatorを作成
        animator = UIDynamicAnimator(referenceView: view)

        // UIGravityBehaviorを作成して、Viewを重力で落下させるように設定
        gravity = UIGravityBehavior(items: [redView])
        animator.addBehavior(gravity)

        // UICollisionBehaviorを作成して、画面の下端で反射させるように設定
        collision = UICollisionBehavior(items: [redView])
        collision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: view.bounds.height), to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        animator.addBehavior(collision)
    }
}
