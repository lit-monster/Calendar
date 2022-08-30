//
//  ChartViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/21.
//

import UIKit
import SwiftUI

final class ChartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let toyshapes = StudyRecordManager.shared.getWeekData()
        let vc = UIHostingController(rootView: ChartContentView(toyShapes: toyshapes))
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailingConstraint = vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottomConstraint = vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        let topConstraint = vc.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, topConstraint])
    }
}
