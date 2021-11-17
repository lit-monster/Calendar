//
//  ChartViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/21.
//

import UIKit

class ChartViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ChartBarCell", bundle: nil), forCellWithReuseIdentifier: "ChartBarCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartBarCell", for: indexPath) as! ChartBarCell
        
        cell.dayLabel.text = String(indexPath.row)
        return cell
    }
}
