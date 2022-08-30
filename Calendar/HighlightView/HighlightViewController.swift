//
//  HightlightViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/04/05.
//

import UIKit
import SwiftUI

class HighlightViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HighlightCell")
        }
    }

    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 64)

        // Do any additional setup after loading the view.
    }
}

extension HighlightViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.contentConfiguration = UIHostingConfiguration {
                HighlightCell(title: "超集中",
                              subTitle: "今日は昨日よりも時間が少なかったです。",
                              current: 34,
                              leftGaugeText: "今日",
                              rightGaugeText: "昨日")
                    .frame(width: self.view.frame.width*0.9)
            }

        case 1:
            cell.contentConfiguration = UIHostingConfiguration {
                HighlightCell(title: "超集中",
                              subTitle: "今日は昨日よりも時間が少なかったです。",
                              current: 34,
                              leftGaugeText: "今日",
                              rightGaugeText: "昨日")
                    .frame(width: self.view.frame.width*0.9)
            }

        default:
            cell.contentConfiguration = UIHostingConfiguration {
                HighlightCell(title: "超集中",
                              subTitle: "今日は昨日よりも時間が少なかったです。",
                              current: 34,
                              leftGaugeText: "今日",
                              rightGaugeText: "昨日")
                    .frame(width: self.view.frame.width*0.9)
            }
        }
        return cell
    }
}
