//
//  LoginBonusViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/10.
//

import UIKit
import SwiftUI

final class LoginBonusViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
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
