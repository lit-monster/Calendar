//
//  LoginBonusViewController.swift
//  Calendar
//
//  Created by Masakaz Ozaki on 2022/10/10.
//

import UIKit
import SwiftUI

final class LoginBonusViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
//        let toyshapes = StudyRecordManager.shared.getWeekData().flatMap { $0.getToyShape() }
//        let totalTime = StudyRecordManager.shared.getLatestWeekTotalStudyTime()
//        print(totalTime)
        let vc = UIHostingController(rootView: LoginBonusContentView())
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view.topAnchor.constraint(equalTo: view.topAnchor)])
    }
}
