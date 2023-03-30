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
        let toyshapes = StudyRecordManager.shared.getWeekData().flatMap { $0.getToyShape() }
        let totalTime = StudyRecordManager.shared.getLatestWeekTotalStudyTime()
        print(totalTime)
        let vc = UIHostingController(rootView: ChartContentView(toyShapes: toyshapes, totalStudyTime: totalTime))
        vc.view.backgroundColor = UIColor.clear
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
    @IBAction func loginBonusButtonPressed() {
        let loginBonusViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginBonus")
        if let sheet = loginBonusViewController.sheetPresentationController {
            sheet.detents = [.custom { context in 0.8 * context.maximumDetentValue }]
        }
        self.present(loginBonusViewController, animated: true)
    }
}
