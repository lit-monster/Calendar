//
//  HightlightViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/04/05.
//

import UIKit
import SwiftUI

class HighlightViewController: UIViewController {
    
    var studyConditionForLast2Weeks = StudyRecordManager.shared.getLast2Weeks()
    var studyConditionForWeek = StudyRecordManager.shared.getWeekData()
    
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
                let yesterday = studyConditionForWeek[1].superConcentratingTime
                let today = studyConditionForWeek[0].superConcentratingTime
                HighlightCell(title: "超集中",
                              subTitle: "今日は昨日の超集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%勉強しました。",
                              breakdowns: [
                                Breakdown(title: "今日", maxValue: studyConditionForWeek[0].total, currentValue: today),
                                Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].total, currentValue: yesterday),
                                Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].total, currentValue: studyConditionForWeek[2].superConcentratingTime),
                                
                              ])
                    .frame(width: self.view.frame.width*0.9)
            }

        case 1:
            cell.contentConfiguration = UIHostingConfiguration {
                let yesterday = studyConditionForWeek[1].concentratingTime
                let today = studyConditionForWeek[0].concentratingTime
                HighlightCell(title: "集中",
                              subTitle: "今日の勉強時間は昨日の集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%です。",
                              breakdowns: [
                                Breakdown(title: "今日", maxValue: studyConditionForWeek[0].total, currentValue: today),
                                Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].total, currentValue: yesterday),
                                Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].total, currentValue: studyConditionForWeek[2].concentratingTime),
                                
                              ])
                    .frame(width: self.view.frame.width*0.9)
            }

        case 2:
            cell.contentConfiguration = UIHostingConfiguration {
                let yesterday = studyConditionForWeek[1].normalTime
                let today = studyConditionForWeek[0].normalTime
                HighlightCell(title: "普通",
                              subTitle: "今日の勉強時間は昨日の普通の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%です。",
                              breakdowns: [
                                Breakdown(title: "今日", maxValue: studyConditionForWeek[0].total, currentValue: today),
                                Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].total, currentValue: yesterday),
                                Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].total, currentValue: studyConditionForWeek[2].normalTime),
                                
                              ])
                    .frame(width: self.view.frame.width*0.9)
            }
            
        case 3:
            cell.contentConfiguration = UIHostingConfiguration {
                let thisWeek = studyConditionForWeek[0].total
                let lastWeek = studyConditionForWeek[1].total
                HighlightCell(title: "週の合計",
                              subTitle: "今週の勉強時間は先週の\(lastWeek > 0 ? String(Int(thisWeek / lastWeek * 100)) : "-")%です。",
                              breakdowns: [
                                Breakdown(title: "今週", maxValue: lastWeek, currentValue: thisWeek)
                              ])
                    .frame(width: self.view.frame.width*0.9)
            }
        default:
            break
        }
        return cell
    }
}
