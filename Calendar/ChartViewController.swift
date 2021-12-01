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
            collectionView.register(UINib(nibName: "ChartBarCell", bundle: .main), forCellWithReuseIdentifier: "ChartBarCell")
        }
    }
    
//    @IBOutlet var collectionViewFlowLayout: UICollectionViewLayout! {
//        didSet {
//            collectionViewFlowLayout.estimatedItemSize = CGSize(width: 20, height: 20)
//        }
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.dataSource = self
//
//            collectionView.backgroundColor = .lightGray
//
//            // レイアウト設定
//            let layout = UICollectionViewFlowLayout()
//            layout.itemSize = CGSize(width: 100, height: 50)
//            collectionView.collectionViewLayout = layout
//    }
}

extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartBarCell", for: indexPath) as! ChartBarCell
        
        cell.dayLabel.text = String(indexPath.row)
        return cell
    }
}


extension ChartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 7, height: 328)
    }
}
